//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct ItemColorDisplayView: View {
    let selectedColor: ClothingColor

    var body: some View {
        HStack {
            Text(selectedColor.displayString)
                .attributeDisplayViewStyle()
        }
    }
}
