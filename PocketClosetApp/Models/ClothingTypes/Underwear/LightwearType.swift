//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/23/24.
//

import Foundation
import RealmSwift

class LightwearType: ClothingItemType {
    @Persisted var subCategory: LightwearCategory
    
    init(subCategory: LightwearCategory) {
        self.subCategory = subCategory
        super.init(category: .lightwear)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    override var displayString: String {
        return "\(super.displayString) > \(subCategory.displayString)"
    }
}


