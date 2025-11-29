//
//  BooksContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import CoreData
import UIKit

final class BooksContainer {
    
    let persistentContainer: NSPersistentContainer
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "BooksDataModel")
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, _ in }
        
        if forPreview {
            addMockDataDetails(moc: persistentContainer.viewContext)
        }
    }
    
}

extension BooksContainer {
    
    func addMockData(moc: NSManagedObjectContext) {
        BookEntity(context: moc).title = "Combine Mastery in SwiftUI"
        BookEntity(context: moc).title = "Concurrency Concepts"
        BookEntity(context: moc).title = "Core Data Mastery in SwiftUI"
        BookEntity(context: moc).title = "SwiftUI Views Mastery"
        BookEntity(context: moc).title = "SwiftUI Animations Mastery"
        BookEntity(context: moc).title = "Working with Data in SwiftUI"
        
        try? moc.save()
    }
    
    func addMockDataDetails(moc: NSManagedObjectContext) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        addBook(moc: moc, title: "SwiftUI Views Quick Start", cover: "magic1", pages: 300, price: 0, url: "free-swiftui-book", lastUpdated: dateFormatter.date(from: "04-25-2022")!)
        addBook(moc: moc, title: "Combine Mastery in SwiftUI", cover: "magic2", pages: 429, price: 233, url: "combine", lastUpdated: dateFormatter.date(from: "04-23-2022")!)
        addBook(moc: moc, title: "SwiftUI Views Mastery", cover: "magic3", pages: 961, url: "views-16", lastUpdated: dateFormatter.date(from: "04-22-2022")!)
        addBook(moc: moc, title: "Working with Data in SwiftUI", cover: "magic4", pages: 300, price: 34, url: "data", lastUpdated: dateFormatter.date(from: "04-25-2022")!)
        addBook(moc: moc, title: "SwiftUI Animations Mastery", cover: "magic5", pages: 458, url: "animations-16", lastUpdated: dateFormatter.date(from: "02-18-2022")!)
        addBook(moc: moc, title: "Core Data Mastery in SwiftUI", cover: "magic6", pages: 300, url: "coredata", lastUpdated: dateFormatter.date(from: "06-25-2022")!)

        try? moc.save()
    }
    
    func addBook(moc: NSManagedObjectContext, title: String, cover: String, pages: Int16, price: Decimal = 55, url: String, lastUpdated: Date, available: Bool = true) {
        let book = BookEntity(context: moc)
        book.bookId = UUID()
        book.title = title
        book.cover = UIImage(named: cover)?.pngData()
        book.pages = pages
        book.price = (price) as NSDecimalNumber
        book.url = URL(string: "https://www.bigmountainstudio.com/\(url)")!
        book.lastUpdated = lastUpdated
        book.available = available
    }
}
