//
//  MOC_Undo.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct MOC_Undo: View {
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
            .navigationTitle("Dont' Forget!")
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        moc.undo()
                    } label: {
                        Image(systemName: "arrow.uturn.left")
                    }
                    
                    Button {
                        try? moc.save()
                    } label: {
                        Image(systemName: "checkmark")
                    }
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
    MOC_Undo()
        .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
}
