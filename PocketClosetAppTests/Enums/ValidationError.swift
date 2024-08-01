//
//  File.swift
//  PocketClosetAppTests
//
//  Created by Robbie Tabor on 6/20/24.
//

import Foundation
enum ValidationError: LocalizedError {
    case missingName
    case missingItemType
    case missingImage
    case missingClothingItems
    
    var errorDescription: String? {
        switch self {
        case .missingName:
            return "Name is required."
        case .missingItemType:
            return "Item type is required."
        case .missingImage:
            return "Image is required."
        case .missingClothingItems:
            return "At least one clothing item is required."
        }
    }
}
