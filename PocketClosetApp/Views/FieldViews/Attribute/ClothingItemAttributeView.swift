//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/23/24.
//

import Foundation

import SwiftUI
import RealmSwift

struct ClothingItemAttributeView: View {
    @ObservedRealmObject var clothingItem: ClothingItem
    @State private var showAttributesSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Category:")
                    .bold()
            }
            .onTapGesture {
                showAttributesSheet = true
            }

            HStack {
                Text("Brand:")
                    .bold()
                ItemBrandDisplayView(selectedBrand: clothingItem.brand)
            }
            .onTapGesture {
                showAttributesSheet = true
            }

            HStack {
                Text("Color:")
                    .bold()
                ItemColorDisplayView(selectedColor: clothingItem.color)
            }
            .onTapGesture {
                showAttributesSheet = true
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .sheet(isPresented: $showAttributesSheet) {
            ClothingItemDetailedAttributeView(clothingItem: clothingItem)
        }
    }
}
