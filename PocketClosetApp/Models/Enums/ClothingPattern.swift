//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/23/24.
//

import Foundation
import RealmSwift

enum ClothingPattern: String, PersistableEnum {
    case solid
    case striped
    case plaid
    case floral
    case abstract

    var displayString: String {
        switch self {
        case .solid:
            return "Solid"
        case .striped:
            return "Striped"
        case .plaid:
            return "Plaid"
        case .floral:
            return "Floral"
        case .abstract:
            return "Abstract"
        }
    }
}
