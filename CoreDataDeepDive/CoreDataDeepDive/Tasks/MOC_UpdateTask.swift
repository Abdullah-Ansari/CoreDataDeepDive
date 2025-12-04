//
//  MOC_UpdateTask.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 05/12/25.
//

import SwiftUI

struct MOC_UpdateTask: View {
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done), SortDescriptor(\.priority)]) private var tasks
    @State private var newTask = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { todo in
                    NavigationLink {
                        EditTaskView(todo: todo)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(todo.viewTaskName)
                                    .strikethrough(todo.done, color: .red)
                                Text(todo.viewDueData)
                                    .font(.caption)
                            }
                            Spacer()
                            Image(systemName: todo.viewPriority)
                                .foregroundStyle(todo.viewPriorityColor)
                        }
                        .font(.title2)
                    }
                    
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    MOC_UpdateTask()
        .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
}

struct EditTaskView: View {
    
    let todo: TaskEntity?
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var taskName: String = ""
    @State private var priority = 0
    @State private var dueDate = Date()
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("task", text: $taskName)
                .textFieldStyle(.roundedBorder)
            
            VStack(alignment: .leading) {
                Text("Priority")
                Picker(selection: $priority) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                } label: {
                    Text("Priority")
                }
                .pickerStyle(.segmented)
            }
            DatePicker("Due Date", selection: $dueDate)
            Button("Save") {
                todo?.taskName = taskName
                todo?.priority = Int16(priority)
                todo?.dueDate = dueDate
                
                try? moc.save()
                
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
        .onAppear() {
            taskName = todo?.viewTaskName ?? ""
            priority = Int(todo?.priority ?? 0)
            dueDate = todo?.dueDate ?? Date()
        }
        .navigationTitle("Edit Task")
    }
}
