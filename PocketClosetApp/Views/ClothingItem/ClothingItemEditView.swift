//
//  ClothingItemEditView.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI
import RealmSwift

struct ClothingItemEditView: View {

    @ObservedRealmObject var clothingItem: ClothingItem
    
    @Binding var styleTags : Set<ClothingStyleTag>
    @Binding var croppedImage : UIImage?
    
    @State private var viewModel : EditClothingItemViewModel = EditClothingItemViewModel()
    let sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    @State private var isCropViewPresented = false
    @State private var isImagePickerPresented = false
    @State var initialImage : UIImage?
    var body: some View {
        VStack{
            
            UploadImagePickerView(selectedImage: $croppedImage, isImagePickerPresented: $isImagePickerPresented)
                .onAppear(){
                    initialImage = croppedImage
                }
                .onChange(of: isImagePickerPresented) {
                    if isImagePickerPresented == false && croppedImage != initialImage {
                        isCropViewPresented = true
                    }
                }.scaledToFit()
            
            VStack{
                    NameEditView(name: $clothingItem.name)
                    DescriptionEditView(description: $clothingItem.itemDescription)
                ClothingItemTypePicker(selectedClothingItemType: $clothingItem.itemType)
                    ItemBrandPicker(selectedBrand: $clothingItem.brand)
                    ItemColorPicker(selectedColor: $clothingItem.color)
                    StyleTagPicker(selectedTags: $styleTags)
                    DateEditView(date: $clothingItem.purchaseDate)
                    }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePickerUpload(selectedImage: $croppedImage, completion: { image in
                self.croppedImage = image
            }, sourceType: sourceType)
        }
        .sheet(isPresented: $isCropViewPresented, onDismiss: {
        }) {
            // Ensure selectedImage is non-nil before presenting the cropper
            if let imageToCrop = croppedImage {
                ImageCropper(isPresented: $isCropViewPresented, selectedImage: imageToCrop, onCrop: { croppedImage in
                    self.croppedImage = croppedImage
                    Task{
                        await removeBackgroundFromImage()
                    }
                    
                },onCancel: {
                    self.croppedImage = initialImage
                })
            }
        }
    }
    private func removeBackgroundFromImage() async {
        if let image = croppedImage{
            croppedImage = await viewModel.removeBackgroundFromSelectedImage(image: image)
        }
    }

}
