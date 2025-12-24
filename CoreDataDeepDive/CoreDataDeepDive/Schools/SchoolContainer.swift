//
//  SchoolContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import CoreData
import UIKit

final class SchoolContainer {
    
    private let persistent: NSPersistentContainer
    
    let viewContext: NSManagedObjectContext
    
    init(forPreview: Bool) {
        persistent = NSPersistentContainer(name: "SchoolDataModel")
        
        viewContext = persistent.viewContext
        
        if forPreview {
            persistent.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistent.loadPersistentStores { _, _ in }
        
        if forPreview {
            addMockData(moc: persistent.viewContext)
        }
    }
    
    
}


extension SchoolContainer {
    func addMockData(moc: NSManagedObjectContext) {
        // Students
        let susan = StudentEntity(context: moc)
        susan.name = "Susan"
        susan.image = UIImage(named: "susan")?.pngData()

        let bob = StudentEntity(context: moc)
        bob.name = "Bob"
        bob.image = UIImage(named: "bob")?.pngData()

        let claudia = StudentEntity(context: moc)
        claudia.name = "Claudia"
        claudia.image = UIImage(named: "claudia")?.pngData()

        let phillip = StudentEntity(context: moc)
        phillip.name = "Phillip"
        phillip.image = UIImage(named: "phillip")?.pngData()
        
        let josie = StudentEntity(context: moc)
        josie.name = "Josie"
        josie.image = UIImage(named: "josie")?.pngData()

        let leo = StudentEntity(context: moc)
        leo.name = "Leo"
        leo.image = UIImage(named: "leo")?.pngData()
        
        let julie = StudentEntity(context: moc)
        julie.name = "Julie"
        julie.image = UIImage(named: "julie")?.pngData()

        
        // Classes
        let math = ClassEntity(context: moc)
        math.subject = "Math"
        math.image = UIImage(named: "math")?.pngData()
        math.students = [susan, phillip, josie, leo, bob]
        let biology = ClassEntity(context: moc)
        biology.subject = "Biology"
        biology.image = UIImage(named: "biology")?.pngData()
        biology.students = [leo, phillip, josie, julie]
        let chemistry = ClassEntity(context: moc)
        chemistry.subject = "Chemistry"
        chemistry.image = UIImage(named: "chemistry")?.pngData()
        chemistry.students = [julie, bob, phillip]
        let art = ClassEntity(context: moc)
        art.subject = "Art"
        art.image = UIImage(named: "art")?.pngData()
        art.students = [susan, phillip, claudia, josie]
        
        try? moc.save()
    }
    
    func addTask(moc: NSManagedObjectContext, taskName: String, done: Bool, dueDate: Date?, priority: Int16) {
        let task = TaskEntity(context: moc)
        task.taskName = taskName
        task.done = done
        task.dueDate = dueDate
        task.priority = priority
    }
}
