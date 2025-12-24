//
//  MOC_Rollback.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct MOC_Rollback: View {
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
            .navigationTitle("Rollback")
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        moc.rollback()
                    } label: {
                        Image(systemName: "lifepreserver")
                    }
                    
                    Button {
                        try? moc.save()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(moc.hasChanges == false)
                }
            }
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(tasks[offset])
        }
    }
}

#Preview {
    MOC_Rollback()
        .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
}
