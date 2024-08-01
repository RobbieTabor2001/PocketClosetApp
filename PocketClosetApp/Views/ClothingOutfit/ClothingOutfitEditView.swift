import Foundation
import SwiftUI
import RealmSwift

struct ClothingOutfitEditView: View {
    @ObservedRealmObject var clothingOutfit: ClothingOutfit
    
    @Binding var styleTags: Set<ClothingStyleTag>
    @Binding var clothingItemIds: Set<ObjectId>
    
    var body: some View {
        ScrollView {
            VStack{
                VStack{

                        NameEditView(name: $clothingOutfit.name)
                        DescriptionEditView(description: $clothingOutfit.outfitDescription)
                        StyleTagPicker(selectedTags: $styleTags)
                        DateEditView(date: $clothingOutfit.createdAt)
                        AddItemsToOutfitView(itemsToAdd: $clothingItemIds)
                }
            }
        }
    }
}
