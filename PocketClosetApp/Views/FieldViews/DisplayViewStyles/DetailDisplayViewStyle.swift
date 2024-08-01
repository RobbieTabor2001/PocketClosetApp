//
//  DetailDisplayViewStyle.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/6/24.
//

import Foundation
import SwiftUI

struct DetailDisplayViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
            .padding(.vertical, 2)
    }
}

extension View {
    func detailDisplayViewStyle() -> some View {
        self.modifier(DetailDisplayViewStyle())
    }
}
