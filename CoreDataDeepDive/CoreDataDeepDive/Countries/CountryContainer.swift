//
//  CountryContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import Foundation
import CoreData

final class CountriesContainer {
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    
    init(forPreview: Bool = false) {
        self.persistentContainer = NSPersistentContainer(name: "CountriesDataModel")
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, _ in }
        backgroundContext = persistentContainer.newBackgroundContext()
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        if forPreview {
            addMockData(moc: persistentContainer.viewContext)
        }
    }
    
    static var shared: CountriesContainer {
        return sharedContriesContainer
    }
    
    private static var sharedContriesContainer: CountriesContainer = {
#if DEBUG
        return CountriesContainer(forPreview: true)
#else
        return CountriesContainer()
#endif
    }()
}

extension CountriesContainer {
    func addMockData(moc: NSManagedObjectContext) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        addCountry(moc: moc, name: "Austria", lastVisited: dateFormatter.date(from: "04-23-2009")!)
        addCountry(moc: moc, name: "England", lastVisited: dateFormatter.date(from: "10-27-2005")!)
        addCountry(moc: moc, name: "Norway", lastVisited: dateFormatter.date(from: "11-5-2023")!)
        addCountry(moc: moc, name: "Italy", lastVisited: dateFormatter.date(from: "07-15-2012")!)
        addCountry(moc: moc, name: "New Zealand", lastVisited: dateFormatter.date(from: "10-10-2000")!)
        addCountry(moc: moc, name: "India", lastVisited: dateFormatter.date(from: "08-1-2014")!)
        addCountry(moc: moc, name: "Germany", lastVisited: dateFormatter.date(from: "09-18-2005")!)
        addCountry(moc: moc, name: "American Samoa", lastVisited: dateFormatter.date(from: "02-17-2001")!)
        
        try? moc.save()
    }
    
    func addCountry(moc: NSManagedObjectContext, name: String, lastVisited: Date) {
        let country = CountryEntity(context: moc)
//        country.id = UUID()
        country.name = name
        country.lastVisited = lastVisited
    }
}
