//
//  ParksContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import CoreData
import UIKit

final class ParksContainer {
    
    let persistentContainer: NSPersistentContainer
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ParksDataModel")
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, _ in }
        if forPreview {
            addMockData(moc: persistentContainer.viewContext)
        }
    }
}

extension ParksContainer {
    func addMockData(moc: NSManagedObjectContext) {
            addPark(moc: moc, name: "Arches", image: "arches", region: "Utah", country: "United States", rating: 6)
            addPark(moc: moc, name: "Yellowstone", image: "yellowstone", region: "Wyoming", country: "United States", rating: 4)
            addPark(moc: moc, name: "Yosemite", image: "yosemite", region: "California", country: "United States", rating: 7)
            addPark(moc: moc, name: "Zion", image: "zion", region: "Utah", country: "United States", rating: 5)
            addPark(moc: moc, name: "Grand Teton", image: "tetons", region: "Wyoming", country: "United States", rating: 11)
            addPark(moc: moc, name: "Banff", image: "banff", region: "Alberta", country: "Canada", rating: 3)
            addPark(moc: moc, name: "Jasper", image: "jasper", region: "Alberta", country: "Canada", rating: 6)
            addPark(moc: moc, name: "Bavarian Forest", image: "bavarian", region: "Bavaria", country: "Germany", rating: 13)
            addPark(moc: moc, name: "Swiss", image: "swiss", region: "Zernez", country: "Switzerland", rating: 4)
            addPark(moc: moc, name: "Dolomites", image: "dolomites", region: "Belluno", country: "Italy", rating: 1)
            addPark(moc: moc, name: "Abel Tasman", image: "abel.tasman", region: "South Island", country: "New Zealand", rating: 10)
            addPark(moc: moc, name: "Dartmoor", image: "dartmoor", region: "Devon", country: "United Kingdom", rating: 12)
            addPark(moc: moc, name: "Grampians", image: "grampians", region: "Victoria", country: "Australia", rating: 8)
        try? moc.save()
    }
    
    func addPark(moc: NSManagedObjectContext, name: String, image: String, region: String, country: String, rating: Int16) {
        let park = ParkEntity(context: moc)
        park.name = name
        park.image = UIImage(named: image)?.pngData()
        park.region = region
        park.country = country
        park.rating = rating
    }
}
