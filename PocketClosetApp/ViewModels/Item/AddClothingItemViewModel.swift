import Foundation
import SwiftUI
import Combine

class AddClothingItemViewModel: ObservableObject {
    // Modified to accept UIImage as parameter
    func removeBackgroundFromSelectedImage(image: UIImage) async -> UIImage? {
        do {
            let processedImage = try await removeBackground(of: image)
            return processedImage
            
        } catch {
            print("Error removing background: \(error)")
            return image
        }
        
    }
    
}
