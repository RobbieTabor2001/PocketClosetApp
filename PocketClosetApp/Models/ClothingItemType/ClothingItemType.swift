//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 7/15/24.
//

import Foundation
import RealmSwift

class ClothingItemType: Object, Identifiable {
    @Persisted var categories: List<ClothingItemTypeCategory>
    @Persisted var name: String
    convenience init(name: String) {
        self.init()
        self.name = name
        self.categories = List<ClothingItemTypeCategory>()
    }
}
