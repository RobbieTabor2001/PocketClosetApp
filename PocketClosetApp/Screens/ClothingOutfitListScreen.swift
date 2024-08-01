import SwiftUI
import RealmSwift

struct ClothingOutfitListScreen: View {
    
    @ObservedResults(ClothingOutfit.self) var clothingOutfits
    @State private var navigationPath = NavigationPath()
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if clothingOutfits.isEmpty {
                    Text("No outfits added!")
                        .padding()
                } else {
                    List {
                        ForEach(clothingOutfits) { clothingOutfit in
                            Button(action: {
                                // Append clothingOutfit to navigate
                                navigationPath.append(clothingOutfit)
                            }) {
                                VStack(alignment: .leading) {
                                    NameDisplayView(name: clothingOutfit.name)
                                    DescriptionDisplayView(description: clothingOutfit.outfitDescription)
                                }
                            }
                        }
                        .onDelete(perform: $clothingOutfits.remove)
                    }
                }
            }
            .navigationTitle("Outfits")
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
                AddClothingOutfitScreen(navigationPath: $navigationPath)
            }
            .navigationDestination(for: ClothingOutfit.self) { selectedOutfit in
                // Assuming ClothingOutfitDetailScreen can be initialized with just a ClothingOutfit
                ClothingOutfitDetailScreen(clothingOutfit: selectedOutfit, navigationPath: $navigationPath)
            }
        }
    }
}
