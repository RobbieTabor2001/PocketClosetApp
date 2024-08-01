//
//  MaterialComposition.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 6/23/24.
//

import Foundation
import RealmSwift

class ClothingMaterialComposition: EmbeddedObject {
    @Persisted var material: ClothingMaterial
    @Persisted var percentage: Double // Percentage of this material

    convenience init(material: ClothingMaterial, percentage: Double) {
        self.init()
        self.material = material
        self.percentage = percentage
    }
}
