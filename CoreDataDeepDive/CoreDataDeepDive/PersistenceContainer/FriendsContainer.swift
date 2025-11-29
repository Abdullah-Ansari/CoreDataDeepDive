//
//  FriendsContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import Foundation
import CoreData

final class FriendsContainer {
    
    let persistentContainer: NSPersistentContainer
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "FriendsDataModel")
        
        print(persistentContainer.persistentStoreDescriptions.first!.url!.absoluteString)
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, _ in }
        
        // this condition, should be after loadPersistentStores
        if forPreview {
            addMockData(moc: persistentContainer.viewContext)
        }
    }
}

extension FriendsContainer {
    
    func addMockData(moc: NSManagedObjectContext) {
        let friend1 = FriendEntity(context: moc)
        friend1.firstName = "Chris"
        friend1.lastName = "Bloom"
        
        let friend2 = FriendEntity(context: moc)
        friend2.firstName = "Jaqueline"
        friend2.lastName = "Cruz"
        
        let friend3 = FriendEntity(context: moc)
        friend3.firstName = "Rodrigo"
        friend3.lastName = "Jones"
        
        try? moc.save()
    }
}
