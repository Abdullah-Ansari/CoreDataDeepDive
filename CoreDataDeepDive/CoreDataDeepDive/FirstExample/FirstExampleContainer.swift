//
//  FirstExampleContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 26/11/25.
//

import Foundation
import CoreData

final class FirstExampleContainer {
    
    static let modelName = "FirstExampleDataModel"
    
    let persistenceContainer: NSPersistentContainer
    
    init() {
        persistenceContainer = NSPersistentContainer(name: FirstExampleContainer.modelName)
        persistenceContainer.loadPersistentStores { _, _ in }
    }
}
