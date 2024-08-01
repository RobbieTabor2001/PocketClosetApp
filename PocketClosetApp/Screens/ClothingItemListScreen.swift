import SwiftUI
import RealmSwift

struct ClothingItemListScreen: View {
    
    @ObservedResults(ClothingItem.self) var clothingItems
    @State private var navigationPath = NavigationPath()
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if clothingItems.isEmpty {
                    Text("No items added!")
                        .padding()
                } else {
                    List {
                        ForEach(clothingItems) { clothingItem in
                            Button(action: {
                                navigationPath.append(clothingItem)
                            }) {
                                VStack(alignment: .leading) {
                                    NameDisplayView(name: clothingItem.name)
                                    DescriptionDisplayView(description: clothingItem.itemDescription)
                                }
                            }
                        }
                        .onDelete(perform: $clothingItems.remove)
                    }
                }
            }
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddScreen = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $showingAddScreen) {
                // Assuming AddClothingItemScreen can be initialized without needing a NavigationPath.
                // If you need to pass the navigationPath to AddClothingItemScreen, adjust the initializer accordingly.
                AddClothingItemScreen(navigationPath: $navigationPath)
            }
            .navigationDestination(for: ClothingItem.self) { selectedItem in
                // Assuming ClothingOutfitDetailScreen can be initialized with just a ClothingOutfit
                ClothingItemDetailScreen(clothingItem: selectedItem)
            }
            // If you had a detail screen for ClothingItem, you'd set up a navigationDestination for it here, similar to ClothingOutfitDetailScreen
        }
    }
}
