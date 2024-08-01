import Foundation
import UIKit

struct ImageSaver {
    enum ImageSaveError: Error {
        case imageConversionFailed
        case documentsDirectoryNotFound
        case saveToFileSystemFailed(Error)
    }

    // Async version
    static func saveImageToFileSystem(_ image: UIImage?) async throws -> String {
        guard let image = image else {
            throw ImageSaveError.imageConversionFailed
        }

        let uniqueImageName = UUID().uuidString + ".jpg"
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.documentsDirectoryNotFound
        }

        let fileURL = documentsDirectory.appendingPathComponent(uniqueImageName)
        try await saveImageData(image, to: fileURL)
        return uniqueImageName
    }

    // Non-Async version
    static func saveImageToFileSystem(_ image: UIImage?) throws -> String {
        guard let image = image else {
            throw ImageSaveError.imageConversionFailed
        }

        let uniqueImageName = UUID().uuidString + ".jpg"
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.documentsDirectoryNotFound
        }

        let fileURL = documentsDirectory.appendingPathComponent(uniqueImageName)
        try saveImageData(image, to: fileURL)
        return uniqueImageName
    }

    // Async version with specified path
    static func saveImageToFileSystem(_ image: UIImage, atPath path: String) async throws {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.documentsDirectoryNotFound
        }

        let fileURL = documentsDirectory.appendingPathComponent(path)
        try await saveImageData(image, to: fileURL)
    }

    // Non-Async version with specified path
    static func saveImageToFileSystem(_ image: UIImage, atPath path: String) throws {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.documentsDirectoryNotFound
        }

        let fileURL = documentsDirectory.appendingPathComponent(path)
        try saveImageData(image, to: fileURL)
    }

    // Async version to save image data
    private static func saveImageData(_ image: UIImage, to fileURL: URL) async throws {
        guard let imageData = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else {
            throw ImageSaveError.imageConversionFailed
        }

        do {
            try imageData.write(to: fileURL, options: .atomic)
        } catch {
            throw ImageSaveError.saveToFileSystemFailed(error)
        }
    }

    // Non-Async version to save image data
    private static func saveImageData(_ image: UIImage, to fileURL: URL) throws {
        guard let imageData = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else {
            throw ImageSaveError.imageConversionFailed
        }

        do {
            try imageData.write(to: fileURL, options: .atomic)
        } catch {
            throw ImageSaveError.saveToFileSystemFailed(error)
        }
    }
}
