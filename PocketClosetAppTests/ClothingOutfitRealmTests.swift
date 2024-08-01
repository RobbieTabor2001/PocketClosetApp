//
//  ClothingOutfitRealmTests.swift
//  PocketClosetAppTests
//
//  Created by Robbie Tabor on 6/20/24.
//

import Foundation
import XCTest
import RealmSwift
@testable import PocketClosetApp

final class ClothingOutfitRealmTests: XCTestCase {
    
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

    func testCreateClothingOutfit() throws {
        let clothingItem = createSampleClothingItem()
        
        // Simulate UI validation
        XCTAssertNoThrow(try validateInputs(name: "Test Outfit", clothingItems: [clothingItem]))

        // Save the clothing outfit
        saveClothingOutfit(name: "Test Outfit", outfitDescription: "Description", createdAt: Date(), clothingItems: [clothingItem], styleTags: Set())

        let outfits = realm.objects(ClothingOutfit.self)
        XCTAssertEqual(outfits.count, 1, "There should be one outfit in the Realm database")
        XCTAssertEqual(outfits.first?.name, "Test Outfit")
        XCTAssertEqual(outfits.first?.clothingItems.count, 1)
    }

    func testReadClothingOutfit() throws {
        // Create and save a clothing outfit
        try testCreateClothingOutfit()

        let outfits = realm.objects(ClothingOutfit.self)
        XCTAssertEqual(outfits.count, 1, "There should be one outfit in the Realm database")
        XCTAssertEqual(outfits.first?.name, "Test Outfit")
    }

    func testUpdateClothingOutfit() throws {
        // Create and save a clothing outfit
        try testCreateClothingOutfit()

        guard let outfitToUpdate = realm.objects(ClothingOutfit.self).first else {
            XCTFail("Outfit to update not found")
            return
        }

        try realm.write {
            outfitToUpdate.name = "Updated Outfit"
            outfitToUpdate.outfitDescription = "Updated Description"
        }

        let updatedOutfit = realm.objects(ClothingOutfit.self).first
        XCTAssertEqual(updatedOutfit?.name, "Updated Outfit")
        XCTAssertEqual(updatedOutfit?.outfitDescription, "Updated Description")
    }

    func testDeleteClothingOutfit() throws {
        // Create and save a clothing outfit
        try testCreateClothingOutfit()

        guard let outfitToDelete = realm.objects(ClothingOutfit.self).first else {
            XCTFail("Outfit to delete not found")
            return
        }

        try realm.write {
            realm.delete(outfitToDelete)
        }

        let outfits = realm.objects(ClothingOutfit.self)
        XCTAssertEqual(outfits.count, 0, "There should be no outfits in the Realm database")
    }

    // MARK: - Validation Tests

    func testValidation() throws {
        let clothingItem = createSampleClothingItem()

        // Missing name
        XCTAssertThrowsError(try validateInputs(name: "", clothingItems: [clothingItem])) { error in
            XCTAssertEqual(error as? ValidationError, ValidationError.missingName)
        }

        // Missing clothing items
        XCTAssertThrowsError(try validateInputs(name: "Test Outfit", clothingItems: [])) { error in
            XCTAssertEqual(error as? ValidationError, ValidationError.missingClothingItems)
        }
    }

    // MARK: - Helper Methods

    private func validateInputs(name: String, clothingItems: [ClothingItem]) throws {
        if name.isEmpty {
            throw ValidationError.missingName
        }
        if clothingItems.isEmpty {
            throw ValidationError.missingClothingItems
        }
    }

    private func saveClothingOutfit(name: String, outfitDescription: String, createdAt: Date, clothingItems: [ClothingItem], styleTags: Set<StyleTag>) {
        let clothingOutfit = ClothingOutfit()
        clothingOutfit.name = name
        clothingOutfit.outfitDescription = outfitDescription
        clothingOutfit.createdAt = createdAt
        clothingOutfit.clothingItems.append(objectsIn: clothingItems)

        let realmStyleTags = RealmSwift.List<StyleTag>()
        realmStyleTags.append(objectsIn: Array(styleTags))
        clothingOutfit.styleTags = realmStyleTags

        try! realm.write {
            realm.add(clothingOutfit)
        }
    }

    private func createSampleClothingItem() -> ClothingItem {
        let clothingItem = ClothingItem()
        clothingItem.name = "Sample Item"
        clothingItem.itemDescription = "Sample Description"
        clothingItem.purchaseDate = Date()
        clothingItem.imagePath = "sample/path/to/image.jpg"
        clothingItem.itemType = .other
        clothingItem.brand = .none
        clothingItem.color = .red

        try! realm.write {
            realm.add(clothingItem)
        }

        return clothingItem
    }

}

