//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import RealmSwift

enum ClothingStyleTag: Int, PersistableEnum, CaseIterable {
    case rockabilly = 1
    case gorpcore
    case streetwear
    case vintage
    case boho
    case preppy
    case athleisure
    case grunge
    case minimalist
    case techwear
    case punk
    case couture
    case casualChic
    case avantGarde
    case normcore

    var displayString: String {
        switch self {
        case .rockabilly: return "Rockabilly"
        case .gorpcore: return "Gorpcore"
        case .streetwear: return "Streetwear"
        case .vintage: return "Vintage"
        case .boho: return "Boho"
        case .preppy: return "Preppy"
        case .athleisure: return "Athleisure"
        case .grunge: return "Grunge"
        case .minimalist: return "Minimalist"
        case .techwear: return "Techwear"
        case .punk: return "Punk"
        case .couture: return "Couture"
        case .casualChic: return "Casual Chic"
        case .avantGarde: return "Avant-Garde"
        case .normcore: return "Normcore"
        }
    }
}
