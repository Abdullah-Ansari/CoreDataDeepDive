//
//  AutosContainer.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import CoreData

final class AutosContainer {
    
    let persistent: NSPersistentContainer
    
    init(forPreview: Bool) {
        persistent = NSPersistentContainer(name: "AutosDataModel")
        
        if forPreview {
            persistent.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistent.loadPersistentStores { _, _ in }
        
        if forPreview {
            addMockData(moc: persistent.viewContext)
        }
        
    }
    
}

extension AutosContainer {
    func addMockData(moc: NSManagedObjectContext) {
        let audi = ManufacturerEntity(context: moc)
        audi.name = "Audi"
        audi.country = "Germany"
        audi.autoEntities = [addAuto(moc: moc, model: "Q4 e-tron", year: "2024"),
                             addAuto(moc: moc, model: "e-tron GT", year: "2024"),
                             addAuto(moc: moc, model: "RS e-tron GT", year: "2024")]
        
        let rivian = ManufacturerEntity(context: moc)
        rivian.name = "Rivian"
        rivian.country = "USA"
        rivian.autoEntities = [addAuto(moc: moc, model: "R1S", year: "2024"),
                               addAuto(moc: moc, model: "R1U", year: "2024"),
                               addAuto(moc: moc, model: "R1T", year: "2024")]
        
        let toyota = ManufacturerEntity(context: moc)
        toyota.name = "Toyota"
        toyota.country = "Japan"
        toyota.autoEntities = [addAuto(moc: moc, model: "bZ4X", year: "2024"),
                               addAuto(moc: moc, model: "RAV4 Prime", year: "2024"),
                               addAuto(moc: moc, model: "Mirai", year: "2024")]
        
        let tesla = ManufacturerEntity(context: moc)
        tesla.name = "Tesla"
        tesla.country = "USA"
        tesla.autoEntities = [addAuto(moc: moc, model: "Model S", year: "2024"),
                              addAuto(moc: moc, model: "Model Y", year: "2024"),
                              addAuto(moc: moc, model: "Model X", year: "2024")]
        
        try? moc.save()
    }
    
    func addAuto(moc: NSManagedObjectContext, model: String, year: String) -> AutoEntity {
        // Notice we don't have to specify the manufacturer because of the inverse relationship set in the data model.
        let auto = AutoEntity(context: moc)
        auto.model = model
        auto.year = year
        return auto
    }
}
