//
//  MOC_Undo_HasChanges.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct MOC_Undo_HasChanges: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)]) private var tasks
    @State private var allSaved = true
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    Text(task.viewTaskName)
                        .strikethrough(task.done, color: .red)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Has Changes")
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        moc.undo()
                        allSaved = (moc.hasChanges == false)
                    } label: {
                        Image(systemName: "arrow.uturn.left")
                    }
                    .disabled(allSaved)
                    
                    Button {
                        try? moc.save()
                        allSaved = (moc.hasChanges == false)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(allSaved)
                }
            }
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(tasks[offset])
        }
        allSaved = false
    }
}

#Preview {
    MOC_Undo_HasChanges()
        .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
}
