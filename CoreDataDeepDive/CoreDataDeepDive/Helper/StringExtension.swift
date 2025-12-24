//
//  StringExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
}
