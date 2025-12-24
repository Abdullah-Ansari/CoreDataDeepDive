//
//  StudentEntity.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import UIKit
import SwiftUI

extension StudentEntity {
    
    var viewName: String {
        return name ?? ""
    }
    
    var viewImage: Image {
        return Image(uiImage: UIImage(data: image!) ?? UIImage(named: "earth")!)
    }
    
    var viewClasses: [ClassEntity] {
        return classes?.allObjects as? [ClassEntity] ?? []
    }
}
