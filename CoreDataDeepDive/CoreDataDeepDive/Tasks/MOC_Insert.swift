//
//  MOC_Insert.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 08/12/25.
//

import SwiftUI

struct MOC_Insert: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)]) private var tasks
    @State private var newTask = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { todo in
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
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem {
                    Button {
                        newTask.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $newTask) {
                InsertTaskView()
            }
        }
    }
}

#Preview {
    MOC_Insert()
            .environment(\.managedObjectContext, TasksContainer(forPreview: true).persistentContainer.viewContext)
}



struct InsertTaskView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var taskName = ""
    @State private var priority = 1
    @State private var dueDate = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("task", text: $taskName)
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
                    let task = TaskEntity(context: moc)
                    task.taskName = taskName
                    task.priority = Int16(priority)
                    task.dueDate = dueDate
                    
                    try? moc.save()
                    
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            } header: {
                Text("New Task")
            }
            .headerProminence(.increased)
        }
    }
}
