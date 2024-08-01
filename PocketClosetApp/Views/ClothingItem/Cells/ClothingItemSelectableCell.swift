
import Foundation
import SwiftUI
import RealmSwift

struct ClothingItemSelectableCell: View {
    
    let item: ClothingItem
    var selected: Bool
    let isSelected: (Bool) -> Void
    
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
                
                if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.green, lineWidth: 2))
                        .padding(10) // Adjust padding to ensure it does not overlap too much with the text
                }
            }
            .onTapGesture {
                isSelected(!selected)
            }
            .shadow(radius: 5) // Adds a shadow to the entire cell for depth
        }
        .padding(.vertical, 5)
    }
}
