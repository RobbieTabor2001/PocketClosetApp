//
//  ClothingColor.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/2/24.
//

import Foundation
import RealmSwift

enum ClothingColor: Int, PersistableEnum, CaseIterable {
    case red = 1
    case orange
    case yellow
    case green
    case blue
    case indigo
    case violet
    case black
    case white
    case gray
    case other
    case none
    
    var displayString: String {
        switch self {
        case .none: return "No Color Selected"
        case .red: return "Red"
        case .orange: return "Orange"
        case .yellow: return "Yellow"
        case .green: return "Green"
        case .blue: return "Blue"
        case .indigo: return "Indigo"
        case .violet: return "Violet"
        case .black: return "Black"
        case .white: return "White"
        case .gray: return "Gray"
        case .other: return "Other"
        
        }
    }
}
