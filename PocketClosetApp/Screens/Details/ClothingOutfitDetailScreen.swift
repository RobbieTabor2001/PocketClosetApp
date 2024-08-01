import SwiftUI
import RealmSwift

struct ClothingOutfitDetailScreen: View {
    @ObservedRealmObject var clothingOutfit: ClothingOutfit
    @State private var isEditing = false
    @Binding var navigationPath: NavigationPath
    
    @State private var styleTags: Set<ClothingStyleTag> = []
    @State private var clothingItemIds: Set<ObjectId> = []
    
    var body: some View {
        VStack{
            if isEditing {
                ClothingOutfitEditView(clothingOutfit: clothingOutfit, styleTags: $styleTags, clothingItemIds: $clothingItemIds)
            } else {
                ClothingOutfitDisplayView(clothingOutfit: clothingOutfit, navigationPath: $navigationPath)
            }
        }
        .navigationTitle(clothingOutfit.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(isEditing ? "Done" : "Edit") {
                if isEditing{
                    update()
                } else{
                    styleTags = Set(clothingOutfit.styleTags)
                    clothingItemIds = Set(clothingOutfit.clothingItems.map { $0.id })
                }
                isEditing.toggle()
            }
        }
    }
        private func update() {
            let realm = try! Realm() // Consider handling this try! more safely in production code
            
            if let objectToUpdate = realm.object(ofType: ClothingOutfit.self, forPrimaryKey: clothingOutfit.id) {
                try! realm.write {
                    // Clear existing items and tags
                    objectToUpdate.clothingItems.removeAll()
                    objectToUpdate.styleTags.removeAll()
                    
                    // Add new clothing items by fetching them using their IDs
                    for itemId in clothingItemIds {
                        if let itemToAdd = realm.object(ofType: ClothingItem.self, forPrimaryKey: itemId) {
                            objectToUpdate.clothingItems.append(itemToAdd)
                        }
                    }
                    
                    let realmStyleTags = RealmSwift.List<ClothingStyleTag>()
                    realmStyleTags.append(objectsIn: Array(styleTags))
                    objectToUpdate.styleTags = realmStyleTags
                }
            }
            clothingItemIds.removeAll()
            styleTags.removeAll()
        }
    }



