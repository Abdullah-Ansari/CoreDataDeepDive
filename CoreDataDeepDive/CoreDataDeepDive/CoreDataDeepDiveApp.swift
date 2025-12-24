//
//  CoreDataDeepDiveApp.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 18/11/25.
//

import SwiftUI

@main
struct CoreDataDeepDiveApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            FirstExampleView()
//                .environment(\.managedObjectContext, FirstExampleContainer().persistenceContainer.viewContext)
//            DataModels_Optional_Updates()
//                .environment(\.managedObjectContext, AnimalsContainer(forPreview: true).persistent.viewContext)
            
            MOC_Undo()
                .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
            
        }
    }
}
