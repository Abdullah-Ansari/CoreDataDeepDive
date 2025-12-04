//
//  TaskEntityExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 04/12/25.
//

import SwiftUI

extension TaskEntity {
    
    var viewTaskName: String {
        taskName ?? ""
    }
    
    var viewDueData: String {
        dueData?.formatted(date: .numeric, time: .omitted) ?? ""
    }
    
    var viewPriority: String {
        "\(priority).circle.fill"
    }
    
    var viewPriorityColor: Color {
        if done {
            return .gray
        } else if priority == 1 {
            return .green
        } else if priority == 2 {
            return .yellow
        }
        return .red
    }
    
}
