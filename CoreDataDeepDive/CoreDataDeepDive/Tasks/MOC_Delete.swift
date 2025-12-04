//
//  MOC_Delete.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 04/12/25.
//

import SwiftUI

struct MOC_Delete: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)]) private var tasks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    Text(task.viewTaskName)
                        .strikethrough(task.done, color: .red)
                    
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Tasks")
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(tasks[offset])
        }
        try? moc.save()
    }
    
}

#Preview {
    MOC_Delete()
        .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
}
