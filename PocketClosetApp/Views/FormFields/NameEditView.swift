//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import SwiftUI

struct NameEditView: View {
    @Binding var name: String // Use a binding to allow for changes

    var body: some View {
        VStack(alignment: .leading){
            Text("Name:")
                .bold()
            TextField("Enter Name", text: $name) // Bind the TextField to the name
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
