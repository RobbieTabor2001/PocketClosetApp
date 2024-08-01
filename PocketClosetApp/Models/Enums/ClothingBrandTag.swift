//
//  BrandTag.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import RealmSwift

enum ClothingBrandTag: Int, PersistableEnum, CaseIterable {
    case northFace = 1
    case levis
    case carhartt
    case nike
    case adidas
    case patagonia
    case supreme
    case gucci
    case prada
    case versace
    case other
    case none

    var displayString: String {
        switch self {
        case .none: return "No Brand Selected"
        case .northFace: return "The North Face"
        case .levis: return "Levi's"
        case .carhartt: return "Carhartt"
        case .nike: return "Nike"
        case .adidas: return "Adidas"
        case .patagonia: return "Patagonia"
        case .supreme: return "Supreme"
        case .gucci: return "Gucci"
        case .prada: return "Prada"
        case .versace: return "Versace"
        case .other: return "Other"
        
        }
    }
}
