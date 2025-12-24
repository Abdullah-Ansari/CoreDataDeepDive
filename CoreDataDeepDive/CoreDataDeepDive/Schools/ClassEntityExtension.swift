//
//  ClassEntityExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI
import UIKit

extension ClassEntity {
    
    var viewSubject: String {
        return subject ?? ""
    }
    
    var viewImage: Image {
        return Image(uiImage: UIImage(data: image!) ?? UIImage(named: "earth")!)
    }
    
    var viewStudents: [StudentEntity] {
        return students?.allObjects as? [StudentEntity] ?? []
    }
    
}
