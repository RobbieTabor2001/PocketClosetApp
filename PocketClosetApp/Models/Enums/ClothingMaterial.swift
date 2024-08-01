//
//  Material.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/23/24.
//

import Foundation
import Foundation
import RealmSwift

enum ClothingMaterial: String, PersistableEnum {
    case cotton
    case polyester
    case wool
    case silk
    case linen
    case leather
    case denim
    case spandex
    case nylon
    case acrylic
    case rayon
    case cashmere

    var displayString: String {
        switch self {
        case .cotton: return "Cotton"
        case .polyester: return "Polyester"
        case .wool: return "Wool"
        case .silk: return "Silk"
        case .linen: return "Linen"
        case .leather: return "Leather"
        case .denim: return "Denim"
        case .spandex: return "Spandex"
        case .nylon: return "Nylon"
        case .acrylic: return "Acrylic"
        case .rayon: return "Rayon"
        case .cashmere: return "Cashmere"
        }
    }
}
