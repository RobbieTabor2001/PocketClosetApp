//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct DateEditView: View {
    @Binding var date: Date

    var body: some View {
        DatePicker(
            "Purchase Date",
            selection: $date,
            displayedComponents: .date
        )
        .datePickerStyle(GraphicalDatePickerStyle())
    }
}
