import SwiftUI
import RealmSwift

@main
struct PocketClosetAppApp: SwiftUI.App {
    init() {
        setupRealmIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupRealmIfNeeded() {
        let realm = try! Realm()
        
        // Check if the setup has already been done
        if !UserDefaults.standard.bool(forKey: "isRealmSetupDone") {
            setupRealm(realm)
            
            // Set the flag to indicate that the setup has been done
            UserDefaults.standard.set(true, forKey: "isRealmSetupDone")
        }
    }
    
    private func setupRealm(_ realm: Realm) {
        // Create the root node
        
        // Define categories and subcategories
        let outerwear = ClothingItemTypeCategory(name: "Outerwear", topLevel: true)
        let outerwearTops = ClothingItemTypeCategory(name: "Tops")
        let outerwearBottoms = ClothingItemTypeCategory(name: "Bottoms")
        let outerwearDresses = ClothingItemTypeCategory(name: "Dresses")
        
        let midwear = ClothingItemTypeCategory(name: "Midwear", topLevel: true)
        let midwearTops = ClothingItemTypeCategory(name: "Tops")
        let midwearBottoms = ClothingItemTypeCategory(name: "Bottoms")
        let midwearDresses = ClothingItemTypeCategory(name: "Dresses")
        
        let lightwear = ClothingItemTypeCategory(name: "Lightwear", topLevel: true)
        let lightwearTops = ClothingItemTypeCategory(name: "Tops")
        let lightwearBottoms = ClothingItemTypeCategory(name: "Bottoms")
        let lightwearDresses = ClothingItemTypeCategory(name: "Dresses")
        
        let other = ClothingItemTypeCategory(name: "Misc", topLevel: true)
        let accessories = ClothingItemTypeCategory(name: "Accessories")
        
        // Define specific clothing items
        let shirt = ClothingItemType(name: "Shirt")
        let tShirt = ClothingItemType(name: "T-Shirt")
        let sweater = ClothingItemType(name: "Sweater")
        let jacket = ClothingItemType(name: "Jacket")
        let coat = ClothingItemType(name: "Coat")
        let pants = ClothingItemType(name: "Pants")
        let jeans = ClothingItemType(name: "Jeans")
        let shorts = ClothingItemType(name: "Shorts")
        let skirt = ClothingItemType(name: "Skirt")
        let dress = ClothingItemType(name: "Dress")
        let shoes = ClothingItemType(name: "Shoes")
        let boots = ClothingItemType(name: "Boots")
        let sandals = ClothingItemType(name: "Sandals")
        let hat = ClothingItemType(name: "Hat")
        let scarf = ClothingItemType(name: "Scarf")
        let gloves = ClothingItemType(name: "Gloves")
        let belt = ClothingItemType(name: "Belt")
        
        // Assign items to categories
        outerwearTops.items.append(objectsIn: [jacket, coat])
        outerwearBottoms.items.append(objectsIn: [pants])
        outerwearDresses.items.append(objectsIn: [dress])
        
        midwearTops.items.append(objectsIn: [shirt, sweater])
        midwearBottoms.items.append(objectsIn: [pants, jeans])
        midwearDresses.items.append(objectsIn: [dress])
        
        lightwearTops.items.append(objectsIn: [tShirt])
        lightwearBottoms.items.append(objectsIn: [shorts, skirt])
        lightwearDresses.items.append(objectsIn: [dress])
        
        accessories.items.append(objectsIn: [hat, scarf, gloves, belt])
        
        shoes.categories.append(objectsIn: [other])
        boots.categories.append(objectsIn: [other])
        sandals.categories.append(objectsIn: [other])
        
        // Add categories to items
        jacket.categories.append(objectsIn: [outerwear, outerwearTops])
        coat.categories.append(objectsIn: [outerwear, outerwearTops])
        pants.categories.append(objectsIn: [outerwear, outerwearBottoms, midwear, midwearBottoms])
        dress.categories.append(objectsIn: [outerwear, outerwearDresses, midwear, midwearDresses, lightwear, lightwearDresses])
        shirt.categories.append(objectsIn: [midwear, midwearTops])
        sweater.categories.append(objectsIn: [midwear, midwearTops])
        tShirt.categories.append(objectsIn: [lightwear, lightwearTops])
        jeans.categories.append(objectsIn: [midwear, midwearBottoms])
        shorts.categories.append(objectsIn: [lightwear, lightwearBottoms])
        skirt.categories.append(objectsIn: [lightwear, lightwearBottoms])
        shoes.categories.append(objectsIn: [other])
        boots.categories.append(objectsIn: [other])
        sandals.categories.append(objectsIn: [other])
        hat.categories.append(objectsIn: [other, accessories])
        scarf.categories.append(objectsIn: [other, accessories])
        gloves.categories.append(objectsIn: [other, accessories])
        belt.categories.append(objectsIn: [other, accessories])
        
        // Add subcategories to categories
        outerwear.categories.append(objectsIn: [outerwearTops, outerwearBottoms, outerwearDresses])
        midwear.categories.append(objectsIn: [midwearTops, midwearBottoms, midwearDresses])
        lightwear.categories.append(objectsIn: [lightwearTops, lightwearBottoms, lightwearDresses])
        other.categories.append(objectsIn: [accessories])
        
        let nycInkImage = UIImage(named: "NYCInk")
        let fishingVestImage = UIImage(named: "FishingVest")
        let keepOnTruckingImage = UIImage(named: "KeepOnTrucking")
        
        guard let nycInkPath = try? ImageSaver.saveImageToFileSystem(nycInkImage),
              let fishingVestPath = try? ImageSaver.saveImageToFileSystem(fishingVestImage),
              let keepOnTruckingPath = try? ImageSaver.saveImageToFileSystem(keepOnTruckingImage) else {
            return
        }
        
        let nycInk = ClothingItem()
        nycInk.name = "NYC Ink"
        nycInk.itemDescription = "Stylish NYC inspired ink design t-shirt"
        nycInk.imagePath = nycInkPath
        nycInk.purchaseDate = Date()
        nycInk.brand = .supreme
        nycInk.color = .black
        nycInk.cost = 35.0
        nycInk.itemType = tShirt
        
        let fishingVest = ClothingItem()
        fishingVest.name = "40s Fishing Vest"
        fishingVest.itemDescription = "Utility vest perfect for fishing trips"
        fishingVest.imagePath = fishingVestPath
        fishingVest.purchaseDate = Date()
        fishingVest.brand = .patagonia
        fishingVest.color = .green
        fishingVest.cost = 75.0
        fishingVest.itemType = jacket

        let keepOnTrucking = ClothingItem()
        keepOnTrucking.name = "Keep On Trucking"
        keepOnTrucking.itemDescription = "Casual t-shirt with a vintage truck print"
        keepOnTrucking.imagePath = keepOnTruckingPath
        keepOnTrucking.purchaseDate = Date()
        keepOnTrucking.brand = .levis
        keepOnTrucking.color = .blue
        keepOnTrucking.cost = 25.0
        keepOnTrucking.itemType = sweater
        let items = [
            nycInk,
            fishingVest,
            keepOnTrucking,
        ]
        
        // Write to Realm within a write transaction
        try! realm.write {
            realm.add(outerwear)
            realm.add(midwear)
            realm.add(lightwear)
            realm.add(other)
            
            realm.add(shirt)
            realm.add(tShirt)
            realm.add(sweater)
            realm.add(jacket)
            realm.add(coat)
            realm.add(pants)
            realm.add(jeans)
            realm.add(shorts)
            realm.add(skirt)
            realm.add(dress)
            realm.add(shoes)
            realm.add(boots)
            realm.add(sandals)
            realm.add(hat)
            realm.add(scarf)
            realm.add(gloves)
            realm.add(belt)
            
            realm.add(items)
        }
    }
}
