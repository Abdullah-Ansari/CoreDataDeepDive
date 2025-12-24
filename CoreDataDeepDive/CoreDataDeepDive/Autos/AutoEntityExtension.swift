//
//  AutoEntityExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import Foundation

extension AutoEntity {
    
    var viewModel: String {
        return model ?? ""
    }
    
    var viewYear: String {
        return year ?? ""
    }
}
