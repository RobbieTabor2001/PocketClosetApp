import SwiftUI

struct StyleTagPicker: View {
    @Binding var selectedTags: Set<ClothingStyleTag>
    let allTags: [ClothingStyleTag] = ClothingStyleTag.allCases

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
                ForEach(allTags, id: \.self) { tag in
                    Button(action: {
                        toggleTag(tag)
                    }) {
                        StyleTagDisplayView(tag: tag)
                            .overlay(
                                selectedTags.contains(tag) ?
                                    Image(systemName: "checkmark")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding(5) :
                                    nil
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(selectedTags.contains(tag) ? Color.blue : Color.gray)
                    .cornerRadius(5)
                }
            }
            .padding(.horizontal, 15)
        }
    }

    private func toggleTag(_ tag: ClothingStyleTag) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
}
