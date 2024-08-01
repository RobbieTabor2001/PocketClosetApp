import SwiftUI

struct StyleTagArrayDisplayView: View {
    let selectedTags: [ClothingStyleTag]

    // Assuming a standard padding and spacing, adjust these as necessary.
    private let horizontalPadding: CGFloat = 15
    private let spacing: CGFloat = 10

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if !selectedTags.isEmpty {
                LazyHStack(spacing: spacing) {
                    ForEach(selectedTags, id: \.self) { tag in
                        StyleTagDisplayView(tag: tag)
                            .padding(.vertical, 10) // Add some vertical padding for better appearance
                    }
                }
                .padding(.horizontal, horizontalPadding)
            } else {
                Text("No Tags Selected")
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, horizontalPadding)
            }
        }
    }
}
