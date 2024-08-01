import SwiftUI

struct UploadImagePickerView: View {
    @Binding var selectedImage: UIImage?
    @Binding var isImagePickerPresented: Bool

    var body: some View {
            HStack {
                Spacer()
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    VStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        } else {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFill() // Ensure the image fits within the frame without being squished
                                .cornerRadius(10)
                                .foregroundColor(.blue)
                            Text("Tap to select image")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
