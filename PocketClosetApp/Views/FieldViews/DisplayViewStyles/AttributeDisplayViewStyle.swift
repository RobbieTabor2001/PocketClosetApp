//
//  DisplayStyle.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/6/24.
//

import Foundation
import SwiftUI

struct AttributeDisplayViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .padding(.vertical, 1)
    }
}

extension View {
    func attributeDisplayViewStyle() -> some View {
        self.modifier(AttributeDisplayViewStyle())
    }
}
