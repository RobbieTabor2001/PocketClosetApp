import SwiftUI
import RealmSwift

struct ClothingItemDetailedInfoView: View {
    let clothingItem: ClothingItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                NameDisplayView(name: clothingItem.name)
                DescriptionDisplayView(description: clothingItem.description)
                DateDisplayView(date: clothingItem.purchaseDate)
            }
            .padding()
        }
    }
}
