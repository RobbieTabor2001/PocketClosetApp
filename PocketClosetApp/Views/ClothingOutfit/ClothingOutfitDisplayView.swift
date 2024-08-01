import SwiftUI
import RealmSwift

struct ClothingOutfitDisplayView: View {
    @ObservedRealmObject var clothingOutfit: ClothingOutfit
    @Binding var navigationPath: NavigationPath
    
    var items: [ClothingItem] {
        return Array(clothingOutfit.clothingItems)
    }
    
    var body: some View {
        ScrollView {
            VStack{
                NameDisplayView(name: clothingOutfit.name)
                DescriptionDisplayView(description: clothingOutfit.outfitDescription)
                DateDisplayView(date: clothingOutfit.createdAt)
                StyleTagArrayDisplayView(selectedTags: Array(clothingOutfit.styleTags))
                
                if items.isEmpty {
                    Text("No items found.")
                } else {
                    VStack{
                        ForEach(items, id: \.self) { item in
                            Button(action: {
                                navigationPath.append(item)
                            }) {
                                ClothingItemDisplayCell(item: item) 
                            }
                        }
                    }
                }
            }
        }
        .navigationDestination(for: ClothingItem.self) { clothingItem in
            ClothingItemDetailScreen(clothingItem: clothingItem)
        }
    }
}
