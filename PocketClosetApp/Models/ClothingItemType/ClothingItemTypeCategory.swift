
//
//  File.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 7/15/24.
//

import Foundation
import RealmSwift

class ClothingItemTypeCategory: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var categories: List<ClothingItemTypeCategory>
    @Persisted var items: List<ClothingItemType>
    @Persisted var topLevel : Bool
    
    convenience init(name: String, topLevel: Bool = false) {
        self.init()
        self.name = name
        self.categories = List<ClothingItemTypeCategory>()
        self.items = List<ClothingItemType>()
        self.topLevel = topLevel
    }

}
