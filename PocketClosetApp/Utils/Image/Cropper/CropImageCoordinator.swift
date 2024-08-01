import UIKit
import ObjectiveC
import TOCropViewController
class CropImageCoordinator: NSObject, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    var parent: ImageCropper
    
    init(parent: ImageCropper) {
        self.parent = parent
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        parent.onCrop(image)
        parent.isPresented = false
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        parent.isPresented = false
    }
}
