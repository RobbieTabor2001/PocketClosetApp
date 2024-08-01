//
//  ImageViewFromImage.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/20/24.
//

import Foundation
import SwiftUI

struct ImageViewFromImage: View {
    let image: UIImage?

    var body: some View {
        Group {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                Text("Image not found")
                    .foregroundColor(.gray)
            }
        }
    }
}
