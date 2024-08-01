import Foundation
import RealmSwift

class ClothingItem: Object,Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String //Required
    @Persisted var itemDescription: String
    @Persisted var imagePath: String
    @Persisted var purchaseDate: Date
    @Persisted var brand: ClothingBrandTag
    @Persisted var color: ClothingColor
    @Persisted var cost: Double
    @Persisted var itemType: ClothingItemType?
    @Persisted var styleTags: List<ClothingStyleTag> = List<ClothingStyleTag>()
    
    
    //@Persisted var materialComposition: List<ClothingMaterialComposition> = List<ClothingMaterialComposition>()
    //@Persisted var eraCollection: ClothingEraCollection
    //@Persisted var pattern: ClothingPattern
    //@Persisted var imagePaths: List<String> = List<String>()
    
    
    
    static func ==(lhs: ClothingItem, rhs: ClothingItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
