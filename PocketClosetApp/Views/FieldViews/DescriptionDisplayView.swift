
//
//  Item.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct DescriptionDisplayView: View {
    let description: String

    var body: some View {
        HStack {
            Text("Description:")
                .bold()
                .detailDisplayViewStyle()
        }
    }
}

