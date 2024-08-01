//
//  File.swift
//  PocketCloset
//
//  Created by Robbie Tabor on 2/25/24.
//

import Foundation
enum ImageSaveError: Error {
    case documentsDirectoryNotFound
    case imageConversionFailed
    case saveToFileSystemFailed(Error)
}
