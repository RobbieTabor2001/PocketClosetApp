//
//  ItemColorPicker.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//
//

import Foundation
import SwiftUI

struct ItemColorPicker: View {
    @Binding var selectedColor: ClothingColor

    var body: some View {
        Picker("Color", selection: $selectedColor) {
            ForEach(ClothingColor.allCases, id: \.self) { color in
                Text(color.displayString).tag(color)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
