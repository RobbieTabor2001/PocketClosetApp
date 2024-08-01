import Foundation
import SwiftUI
import UIKit
import TOCropViewController

struct ImageCropper: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var selectedImage: UIImage
    var onCrop: (UIImage) -> Void
    var onCancel: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageCropper>) -> TOCropViewController {
        let cropViewController = TOCropViewController(croppingStyle: .default, image: selectedImage)
        cropViewController.delegate = context.coordinator
        
        // Configure the crop view controller for a square aspect ratio
        cropViewController.aspectRatioPreset = .presetSquare
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.resetAspectRatioEnabled = false
        cropViewController.aspectRatioPickerButtonHidden = true
        
        return cropViewController
    }
    
    func updateUIViewController(_ uiViewController: TOCropViewController, context: Context) {
        // Update view controller if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, TOCropViewControllerDelegate {
        var parent: ImageCropper
        
        init(_ parent: ImageCropper) {
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.onCrop(image)
            parent.isPresented = false
        }
        
        func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
            parent.onCancel()
            parent.isPresented = false
        }
    }
}
