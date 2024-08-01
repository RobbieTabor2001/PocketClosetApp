import SwiftUI

struct StyleTagDisplayView: View {
    let tag: ClothingStyleTag
    
    var body: some View {
        Text(tag.displayString)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(5)
            .lineLimit(2) // Allow for multiline text
            .multilineTextAlignment(.center) // Center align text
            .fixedSize(horizontal: false, vertical: true) // Fit the text size
    }
}
