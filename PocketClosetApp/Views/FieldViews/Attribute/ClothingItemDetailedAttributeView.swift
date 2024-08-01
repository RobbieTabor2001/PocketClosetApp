//
//  ClothingItemDetailedAttributeView.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/23/24.
//

import Foundation
import SwiftUI
import RealmSwift

struct ClothingItemDetailedAttributeView: View {
    let clothingItem: ClothingItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
            //    ItemTypeDisplayView(selectedCategory: clothingItem.itemType)
               // ItemBrandDisplayView(selectedBrand: clothingItem.brand)
               // ItemColorDisplayView(selectedColor: clothingItem.color)
              //  StyleTagArrayDisplayView(selectedTags: Array(clothingItem.styleTags))
                // Add additional attributes here when defined
            }
            .padding()
        }
    }
}
