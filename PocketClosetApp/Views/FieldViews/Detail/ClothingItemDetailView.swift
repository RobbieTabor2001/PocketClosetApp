import Foundation
import SwiftUI
import RealmSwift

struct ClothingItemDetailView: View {
    @ObservedRealmObject var clothingItem: ClothingItem
    @State private var showDetailsSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Name:")
                    .bold()
                NameDisplayView(name: clothingItem.name)
            }
            .onTapGesture {
                showDetailsSheet = true
            }
            
            HStack {
                Text("Description:")
                    .bold()
                DescriptionDisplayView(description: clothingItem.itemDescription)
            }
            .onTapGesture {
                showDetailsSheet = true
            }

            HStack {
                Text("Purchase Date:")
                    .bold()
                DateDisplayView(date: clothingItem.purchaseDate)
            }
            .onTapGesture {
                showDetailsSheet = true
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .sheet(isPresented: $showDetailsSheet) {
            ClothingItemDetailedInfoView(clothingItem: clothingItem)
        }
    }
}
