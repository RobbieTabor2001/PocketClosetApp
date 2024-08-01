//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct ItemBrandDisplayView: View {
    let selectedBrand: ClothingBrandTag

    var body: some View {
        HStack {
            Text(selectedBrand.displayString)
                .attributeDisplayViewStyle()
        }
    }
}
