//
//  ImagePicker.swift
//  PocketCloset
//
//  Created by Robbie Tabor on 8/11/23.
//

import SwiftUI
import UIKit

struct ImagePickerUpload: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var completion: (UIImage?) -> Void
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self, completion: completion)
    }


    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerUpload
        var completion: (UIImage?) -> Void

        init(_ parent: ImagePickerUpload, completion: @escaping (UIImage?) -> Void) {
            self.parent = parent
            self.completion = completion
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                // Instead of immediately completing with the image, check if it needs cropping.
                picker.dismiss(animated: true) {
                    // Call completion handler after dismissal to manage flow
                    self.completion(image)
                }
            } else {
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }

}

