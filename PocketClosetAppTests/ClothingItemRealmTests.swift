import XCTest
import RealmSwift
@testable import PocketClosetApp

final class ClothingItemRealmTests: XCTestCase {
    
    var realm: Realm!
    
    override func setUpWithError() throws {
        // Configure in-memory Realm
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name
        realm = try Realm(configuration: config)
    }

    override func tearDownWithError() throws {
        // Clean up
        realm = nil
    }

    // MARK: - CRUD Tests

    func testCreateClothingItem() throws {
        let testImage = UIImage.createTestImage(withColor: .red, size: CGSize(width: 100, height: 100))

        // Simulate UI validation
        XCTAssertNoThrow(try validateInputs(name: "Test Item", itemType: .other, croppedImage: testImage))

        // Save the image using the mock saver
        let savedImagePath = try MockImageSaver.saveImageToFileSystem(testImage)

        // Save the clothing item
        saveClothingItem(name: "Test Item", itemDescription: "Description", purchaseDate: Date(), imagePath: savedImagePath, itemType: .other, brand: .none, color: .red, styleTags: Set())

        let items = realm.objects(ClothingItem.self)
        XCTAssertEqual(items.count, 1, "There should be one item in the Realm database")
        XCTAssertEqual(items.first?.name, "Test Item")
        XCTAssertEqual(items.first?.imagePath, savedImagePath)
    }

    func testReadClothingItem() throws {
        // Create and save a clothing item
        try testCreateClothingItem()

        let items = realm.objects(ClothingItem.self)
        XCTAssertEqual(items.count, 1, "There should be one item in the Realm database")
        XCTAssertEqual(items.first?.name, "Test Item")
    }

    func testUpdateClothingItem() throws {
        // Create and save a clothing item
        try testCreateClothingItem()

        guard let itemToUpdate = realm.objects(ClothingItem.self).first else {
            XCTFail("Item to update not found")
            return
        }

        try realm.write {
            itemToUpdate.name = "Updated Item"
            itemToUpdate.itemDescription = "Updated Description"
        }

        let updatedItem = realm.objects(ClothingItem.self).first
        XCTAssertEqual(updatedItem?.name, "Updated Item")
        XCTAssertEqual(updatedItem?.itemDescription, "Updated Description")
    }

    func testDeleteClothingItem() throws {
        // Create and save a clothing item
        try testCreateClothingItem()

        guard let itemToDelete = realm.objects(ClothingItem.self).first else {
            XCTFail("Item to delete not found")
            return
        }

        try realm.write {
            realm.delete(itemToDelete)
        }

        let items = realm.objects(ClothingItem.self)
        XCTAssertEqual(items.count, 0, "There should be no items in the Realm database")
    }

    // MARK: - Validation Tests

    func testValidation() throws {
        let testImage = UIImage.createTestImage(withColor: .red, size: CGSize(width: 100, height: 100))

        // Missing name
        XCTAssertThrowsError(try validateInputs(name: "", itemType: .other, croppedImage: testImage)) { error in
            XCTAssertEqual(error as? ValidationError, ValidationError.missingName)
        }

        // Missing item type
        XCTAssertThrowsError(try validateInputs(name: "Test Item", itemType: .none, croppedImage: testImage)) { error in
            XCTAssertEqual(error as? ValidationError, ValidationError.missingItemType)
        }

        // Missing image
        XCTAssertThrowsError(try validateInputs(name: "Test Item", itemType: .other, croppedImage: nil)) { error in
            XCTAssertEqual(error as? ValidationError, ValidationError.missingImage)
        }
    }

    // MARK: - Helper Methods

    private func validateInputs(name: String, itemType: ItemType, croppedImage: UIImage?) throws {
        if name.isEmpty {
            throw ValidationError.missingName
        }
        if itemType == .none {
            throw ValidationError.missingItemType
        }
        if croppedImage == nil {
            throw ValidationError.missingImage
        }
    }

    private func saveClothingItem(name: String, itemDescription: String, purchaseDate: Date, imagePath: String, itemType: ItemType, brand: BrandTag, color: ClothingColor, styleTags: Set<StyleTag>) {
        let clothingItem = ClothingItem()
        clothingItem.name = name
        clothingItem.itemDescription = itemDescription
        clothingItem.purchaseDate = purchaseDate
        clothingItem.imagePath = imagePath
        clothingItem.itemType = itemType
        clothingItem.brand = brand
        clothingItem.color = color

        let realmStyleTags = RealmSwift.List<StyleTag>()
        realmStyleTags.append(objectsIn: Array(styleTags))
        clothingItem.styleTags = realmStyleTags

        try! realm.write {
            realm.add(clothingItem)
        }
    }
}



