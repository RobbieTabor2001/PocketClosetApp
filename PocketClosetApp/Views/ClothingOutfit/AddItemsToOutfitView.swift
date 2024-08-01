import SwiftUI
import RealmSwift

struct AddItemsToOutfitView: View {
    
    @ObservedResults(ClothingItem.self) var clothingItems
    @Binding var itemsToAdd: Set<ObjectId>

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(clothingItems) { item in
                    ClothingItemSelectableCell(item: item, selected: itemsToAdd.contains(item.id)) { isSelected in
                        if isSelected {
                            itemsToAdd.insert(item.id)
                        } else {
                            itemsToAdd.remove(item.id)
                        }
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .navigationTitle("Add Items")
        .padding()
    }
}
