import SwiftUI
import RealmSwift

struct AddClothingOutfitScreen: View {
    
    @State private var name: String = ""
    @State private var outfitDescription: String = ""
    @State private var imagePath: String = ""
    @State var clothingItems: Set<ClothingItem> = []
    @State var clothingItemIds: Set<ObjectId> = []
    @State private var styleTags: Set<ClothingStyleTag> = []
    
    @ObservedResults(ClothingOutfit.self) var clothingOutfits
    @ObservedResults(ClothingItem.self) var clothingItemsRealm
    @Binding var navigationPath: NavigationPath
    
    var body: some View {

            Form {
                NameEditView(name: $name)
                DescriptionEditView(description: $outfitDescription)
                StyleTagPicker(selectedTags: $styleTags)
                AddItemsToOutfitView(itemsToAdd: $clothingItemIds)
                
                Button("Save") {
                    let realm = try! Realm() // Ensure this is safe in production code
                    
                    // Start a write transaction
                    try! realm.write {
                        // Create a new ClothingOutfit object
                        let clothingOutfit = ClothingOutfit()
                        clothingOutfit.name = name
                        clothingOutfit.outfitDescription = outfitDescription
                        clothingOutfit.createdAt = Date.now
                        clothingOutfit.imagePath = imagePath
                        
                        let realmStyleTags = RealmSwift.List<ClothingStyleTag>()
                        realmStyleTags.append(objectsIn: Array(styleTags))
                        clothingOutfit.styleTags = realmStyleTags
                        
                        // Fetch each ClothingItem by ID and append it to the ClothingOutfit
                        clothingItemIds.forEach { itemId in
                            if let itemToAdd = realm.object(ofType: ClothingItem.self, forPrimaryKey: itemId) {
                                clothingOutfit.clothingItems.append(itemToAdd)
                            }
                        }
                        
                        // Add the new ClothingOutfit object to the Realm
                        realm.add(clothingOutfit)
                    }
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("New Outfit")

        }
    }
