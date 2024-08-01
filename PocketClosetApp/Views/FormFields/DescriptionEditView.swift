//
//  f.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct DescriptionEditView: View {
    @Binding var description: String // Use a binding to allow for changes

    var body: some View {
        VStack(alignment: .leading) {
            Text("Description:")
                .bold()
            TextField("Enter Description", text: $description) // Bind the TextField to the description
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
