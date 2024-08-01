
import Foundation
import RealmSwift

class ClothingOutfit: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var createdAt: Date
    @Persisted var outfitDescription: String
    @Persisted var imagePath: String
    @Persisted var clothingItems: RealmSwift.List<ClothingItem> = RealmSwift.List<ClothingItem>()
    @Persisted var styleTags: RealmSwift.List<ClothingStyleTag> = RealmSwift.List<ClothingStyleTag>()
    
    
    static func ==(lhs: ClothingOutfit, rhs: ClothingOutfit) -> Bool {
        return lhs.id == rhs.id
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
