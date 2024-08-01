import Foundation
import SwiftUI
import RealmSwift

struct ClothingItemDisplayCell: View {
    
    let item: ClothingItem

    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                ImageViewFromPath(fileName: item.imagePath)
                    .scaledToFit()
                
                Text(item.name)
                    .font(.caption)
                    .padding(5)
                    .background(Color.black.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding([.trailing, .bottom], 8)
            }
            .shadow(radius: 5) // Adds a shadow to the entire cell for depth
        }
        .padding(.vertical, 5)
    }
}
