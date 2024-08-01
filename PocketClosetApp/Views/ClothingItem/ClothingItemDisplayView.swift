import Foundation
import SwiftUI
import RealmSwift

struct ClothingItemDisplayView: View {
    @ObservedRealmObject var clothingItem: ClothingItem
    @Binding var croppedImage: UIImage?

    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                // Image view as a card
                if croppedImage != nil {
                    ImageViewFromImage(image: croppedImage)
                        .cardStyle()
                } else {
                    ImageViewFromPath(fileName: clothingItem.imagePath)
                        .cardStyle()
                }
                
                HStack {
                    Text("Image Selection Row")
                        .foregroundColor(.gray)
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                // Details view
                HStack{
                    ClothingItemDetailView(clothingItem: clothingItem)
                    
                    ClothingItemAttributeView(clothingItem: clothingItem)
                }
                
            }
            .padding()
        }
    }
}

// Extension to apply card style
extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .scaledToFill()

    }
}
