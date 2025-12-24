//
//  AnimalsContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import CoreData

final class AnimalsContainer {
    
    let persistent: NSPersistentContainer
    
    init(forPreview: Bool = false) {
        persistent = NSPersistentContainer(name: "AnimalsDataModel")
        
        if forPreview {
            persistent.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistent.loadPersistentStores { _, _ in }
        
        if forPreview {
            addMockData(moc: persistent.viewContext)
        }
        
    }
}

extension AnimalsContainer {
    
    func addMockData(moc: NSManagedObjectContext) {
        AnimalEntity(context: moc).name = "Dog"
        AnimalEntity(context: moc).name = "Cat"
        AnimalEntity(context: moc).name = "Wolf"
        AnimalEntity(context: moc).name = "Tiger"
        AnimalEntity(context: moc).name = "Dolphin"
        AnimalEntity(context: moc).name = "Penguin"
        AnimalEntity(context: moc).name = "Lion"
        AnimalEntity(context: moc).name = "Horse"
        AnimalEntity(context: moc).name = "Elephant"
        AnimalEntity(context: moc).name = "Fox"
    }
}
