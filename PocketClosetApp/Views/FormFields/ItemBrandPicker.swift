//
//  ItemBrandPicker.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI


struct ItemBrandPicker: View {
    @Binding var selectedBrand: ClothingBrandTag

    var body: some View {
        Picker("Brand", selection: $selectedBrand) {
            ForEach(ClothingBrandTag.allCases, id: \.self) { brand in
                Text(brand.displayString).tag(brand)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
