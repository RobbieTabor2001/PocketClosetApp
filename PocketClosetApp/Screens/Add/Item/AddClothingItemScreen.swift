import SwiftUI
import RealmSwift

struct AddClothingItemScreen: View {
    
    @State private var name: String = ""
    @State private var itemDescription: String = ""
    @State private var imagePath: String = ""
    @State private var purchaseDate: Date = Date.now
    @State private var brand: ClothingBrandTag = .none
    @State private var color: ClothingColor = .none
    @State private var cost: Double = 0.0
    @State private var clothingItemType: ClothingItemType?
    @State private var styleTags: Set<ClothingStyleTag> = Set<ClothingStyleTag>()
    @State private var viewModel: AddClothingItemViewModel = AddClothingItemViewModel()
    @State private var isCropViewPresented = false
    @State private var isImagePickerPresented = false
    @State private var croppedImage: UIImage?
    @State private var errorMessage: String?
    
    @ObservedResults(ClothingItem.self) var clothingItems
    @Binding var navigationPath: NavigationPath
    
    let sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        Form {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            UploadImagePickerView(selectedImage: $croppedImage, isImagePickerPresented: $isImagePickerPresented)
                .onChange(of: isImagePickerPresented) {
                    if isImagePickerPresented == false && croppedImage != nil {
                        isCropViewPresented = true
                    }
                }.scaledToFit()
            
            NameEditView(name: $name)
            DescriptionEditView(description: $itemDescription)
            ItemBrandPicker(selectedBrand: $brand)
            ItemColorPicker(selectedColor: $color)
            ItemCostPicker(itemCost: $cost)
            StyleTagPicker(selectedTags: $styleTags)
            ClothingItemTypePicker(selectedClothingItemType: $clothingItemType)
            Button("Save") {
                Task {
                    do {
                        try validateInputs()
                        
                        if let inputImage = croppedImage {
                            let savedImagePath = try await ImageSaver.saveImageToFileSystem(inputImage)
                            saveClothingItem(withImagePath: savedImagePath)
                           
                        } else {
                            throw ValidationError.missingImage
                        }
                    } catch {
                        handle(error: error)
                    }
                }
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("New Clothing Item")
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePickerUpload(selectedImage: $croppedImage, completion: { image in
                self.croppedImage = image
            }, sourceType: sourceType)
        }
        .sheet(isPresented: $isCropViewPresented, onDismiss: {
            // Discard the image if cropping was cancelled
            if croppedImage == nil {
                croppedImage = nil
            }
        }) {
            // Ensure selectedImage is non-nil before presenting the cropper
            if let imageToCrop = croppedImage {
                ImageCropper(isPresented: $isCropViewPresented, selectedImage: imageToCrop, onCrop: { croppedImage in
                    self.croppedImage = croppedImage
                    Task{
                        await removeBackgroundFromImage()
                    }
                }, onCancel: {
                    self.croppedImage = nil
                })
            }
        }
    }
    
    private func validateInputs() throws {
        if name.isEmpty {
            throw ValidationError.missingName
        }
        if croppedImage == nil {
            throw ValidationError.missingImage
        }
    }
    
    private func saveClothingItem(withImagePath savedImagePath: String) {
        let realm = try! Realm()
        let clothingItem = ClothingItem()
        
        clothingItem.name = name
        clothingItem.itemDescription = itemDescription
        clothingItem.purchaseDate = purchaseDate
        clothingItem.imagePath = savedImagePath
        clothingItem.brand = brand
        clothingItem.color = color
        clothingItem.cost = cost

        try! realm.write {
            realm.add(clothingItem)
        }
    }
    
    private func removeBackgroundFromImage() async {
        if let image = croppedImage {
            croppedImage = await viewModel.removeBackgroundFromSelectedImage(image: image)
        }
    }
    
    private func handle(error: Error) {
        if let validationError = error as? ValidationError {
            switch validationError {
            case .missingName:
                errorMessage = "Name is required."
            case .missingItemType:
                errorMessage = "Item type is required."
            case .missingImage:
                errorMessage = "Image is required."
            }
        } else {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}

enum ValidationError: LocalizedError {
    case missingName
    case missingItemType
    case missingImage
    
    var errorDescription: String? {
        switch self {
        case .missingName:
            return "Name is required."
        case .missingItemType:
            return "Item type is required."
        case .missingImage:
            return "Image is required."
        }
    }
}
