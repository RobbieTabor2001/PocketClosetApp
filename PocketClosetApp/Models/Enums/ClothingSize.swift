//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/23/24.
//

import Foundation

import RealmSwift

enum ClothingSize: String, PersistableEnum {
    case XXS
    case XS
    case S
    case M
    case L
    case XL
    case XXL

    var displayString: String {
        return self.rawValue
    }
}
