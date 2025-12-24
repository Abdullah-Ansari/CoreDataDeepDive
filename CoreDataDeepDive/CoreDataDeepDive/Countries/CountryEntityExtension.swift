//
//  CountryEntityExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import Foundation

extension CountryEntity {
    
    var viewName: String {
        return name ?? "N/A"
    }
    
    var viewLastVisited: String {
        return lastVisited?.formatted(date: .numeric, time: .omitted) ?? ""
    }
    
    override public func awakeFromInsert() {
        id = UUID()
    }
}
