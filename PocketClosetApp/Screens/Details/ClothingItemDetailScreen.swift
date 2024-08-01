import SwiftUI
import RealmSwift

struct ClothingItemDetailScreen: View {
    @ObservedRealmObject var clothingItem: ClothingItem
    @State private var isEditing = false
    @State private var styleTags: Set<ClothingStyleTag> = []
    @State private var croppedImage: UIImage?
    
    var body: some View {
        ScrollView {
            if isEditing {
                ClothingItemEditView(clothingItem: clothingItem, styleTags: $styleTags, croppedImage: $croppedImage) // Pass the observed object directly
            } else {
                ClothingItemDisplayView(clothingItem: clothingItem, croppedImage: $croppedImage)
            }
        }
        .navigationTitle(clothingItem.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(isEditing ? "Done" : "Edit") {
                if isEditing {
                    Task {
                        let imagePath = await saveNewImage()
                        await update(withImagePath: imagePath)
                    }
                } else {
                    styleTags = Set(clothingItem.styleTags)
                    croppedImage = ImageLoader.loadImageFromDisk(withName: clothingItem.imagePath)
                }
                isEditing.toggle()
            }
        }
    }
    
    private func saveNewImage() async -> String {
        var savedImagePath = ""
        do {
            if let inputImage = croppedImage {
                savedImagePath = try await ImageSaver.saveImageToFileSystem(inputImage)
            }
        } catch {
            print("Failed to save image: \(error)")
        }
        return savedImagePath
    }
    
    private func update(withImagePath imagePath: String) async {
        let realm = try! await Realm() // Consider handling this try! more safely in production code
        
        if let objectToUpdate = realm.object(ofType: ClothingItem.self, forPrimaryKey: clothingItem.id) {
            do {
                try realm.write {
                    // Clear existing items and tags
                    objectToUpdate.styleTags.removeAll()
                    
                    let realmStyleTags = RealmSwift.List<ClothingStyleTag>()
                    realmStyleTags.append(objectsIn: Array(styleTags))
                    objectToUpdate.styleTags = realmStyleTags
                    
                    if !imagePath.isEmpty {
                        objectToUpdate.imagePath = imagePath
                    }
                }
            } catch {
                print("Failed to update clothing item: \(error)")
            }
        }
        styleTags.removeAll()
    }
}
