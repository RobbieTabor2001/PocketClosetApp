import SwiftUI
import RealmSwift

struct ClothingItemTypePicker: View {
    @ObservedResults(ClothingItemTypeCategory.self, filter: NSPredicate(format: "topLevel == true")) var topLevelCategories
    @Binding var selectedClothingItemType: ClothingItemType?
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(topLevelCategories, id: \.id) { subcategory in
                ClothingItemTypeCategoryPicker(clothingItemTypeCategory: subcategory, selectedClothingItemType: $selectedClothingItemType)
                    .padding(.bottom, 5)
            }
        }
    }
}

struct ClothingItemTypeCategoryPicker: View {
    @State private var isExpanded: Bool = false
    var clothingItemTypeCategory: ClothingItemTypeCategory
    @Binding var selectedClothingItemType: ClothingItemType?
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(clothingItemTypeCategory.categories, id: \.id) { subcategory in
                    ClothingItemTypeCategoryPicker(clothingItemTypeCategory: subcategory, selectedClothingItemType: $selectedClothingItemType)
                        .padding(.leading, 10)
                }
                
                ForEach(clothingItemTypeCategory.items, id: \.name) { itemType in
                    ItemTypePicker(clothingItemType: itemType, selectedClothingItemType: $selectedClothingItemType)
                        .padding(.leading, 10)
                }
            }
        } label: {
            Text(clothingItemTypeCategory.name)
                .font(.subheadline)
                .padding(.vertical, 5)
        }
        .padding(.vertical, 5)
    }
}

struct ItemTypePicker: View {
    var clothingItemType: ClothingItemType
    @Binding var selectedClothingItemType: ClothingItemType?
    
    var body: some View {
        Button(action: {
            selectedClothingItemType = clothingItemType
        }) {
            Text(clothingItemType.name)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(5)
                .background(selectedClothingItemType == clothingItemType ? Color.blue : Color.gray)
                .cornerRadius(5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
