import Foundation
import RealmSwift

class ClothingEraCollection: EmbeddedObject {
    @Persisted var decade: Int?
    @Persisted var season: String?
    @Persisted var year: Int?

    convenience init(decade: Int? = nil, season: String? = nil, year: Int? = nil) {
        self.init()
        if let year = year {
            self.decade = (year / 10) * 10
        } else {
            self.decade = decade
        }
        self.season = season
        self.year = year
    }
    
    var displayString: String {
        var parts: [String] = []
        if let decade = decade {
            parts.append("\(decade)s")
        }
        if let season = season, let year = year {
            parts.append("\(season.uppercased()) \(year)")
        }
        return parts.joined(separator: " / ")
    }
}
