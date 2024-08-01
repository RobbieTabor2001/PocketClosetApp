
//
//  Item.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct NameDisplayView: View {
    let name: String

    var body: some View {
        HStack {
            Text(name)
                .detailDisplayViewStyle()
        }
    }
}
