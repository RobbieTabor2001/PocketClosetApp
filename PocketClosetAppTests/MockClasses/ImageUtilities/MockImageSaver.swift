//
//  File.swift
//  PocketClosetAppTests
//
//  Created by Robbie Tabor on 6/20/24.
//

import Foundation
import SwiftUI

class MockImageSaver {
    static func saveImageToFileSystem(_ image: UIImage) throws -> String {
        // Simulate saving the image and return a mock path
        return "mock/path/to/saved/image.jpg"
    }
}
