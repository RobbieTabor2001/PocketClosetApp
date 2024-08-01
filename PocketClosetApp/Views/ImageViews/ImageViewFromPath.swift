import Foundation
import SwiftUI

struct ImageViewFromPath: View {
    let fileName: String
    @State private var loadedImage: UIImage?

    var body: some View {
        Group {
            if let uiImage = loadedImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                Text("Image not found")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loadedImage = ImageLoader.loadImageFromDisk(withName: fileName)
        }
        .onChange(of: fileName) {
            loadedImage = ImageLoader.loadImageFromDisk(withName: fileName)
        }
    }
}




