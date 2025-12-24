//
//  ManufacturerEntityExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import Foundation

extension ManufacturerEntity {
    
    var viewName: String {
        return name ?? "N/A"
    }
    
    var viewCountry: String {
        return country ?? "[Not Specified]"
    }
    
    var viewAutoEntities: [AutoEntity] {
        // Convert NSSet to Array
        return autoEntities?.allObjects as? [AutoEntity] ?? []
    }
}
