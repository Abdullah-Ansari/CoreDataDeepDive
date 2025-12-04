//
//  MOC_UpdateWithSwipe.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 04/12/25.
//

import SwiftUI

struct MOC_UpdateWithSwipe: View {
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)]) private var tasks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    
                    Text(task.viewTaskName)
                        .strikethrough(task.done, color: .red)
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                task.done.toggle()
                                try? moc.save()
                            } label: {
                                Image(systemName: task.done
                                      ? "arrow.uturn.backward.square"
                                      : "checkmark.square")
                            }
                            .tint(task.done ? .blue : .green)
                        }

                }
                .listStyle(.automatic)
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    MOC_UpdateWithSwipe()
        .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
}
