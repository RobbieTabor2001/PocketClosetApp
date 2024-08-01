//
//  ItemBrandPicker.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct ItemCostPicker: View {
    @Binding var itemCost: Double
    
    // NumberFormatter to format and parse numeric values
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        HStack{
            Text("$")
                .bold()
            TextField("Item Cost", value: $itemCost, formatter: numberFormatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad) // Ensure the keyboard shows numeric input
        }
        .padding()
    }
}
