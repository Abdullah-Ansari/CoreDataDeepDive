//
//  Relationships_ManyToMany.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct Relationships_ManyToMany: View {
    @FetchRequest<StudentEntity>(sortDescriptors: []) private var students
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                NavigationLink {
                    ClassView(student: student)
                } label: {
                    Label {
                        VStack(alignment: .leading) {
                            Text(student.viewName)
                                .font(.title2.width(.condensed).bold())
                            
                            Text("See what classes they are taking")
                                .font(.footnote.weight(.light).italic())
                                .foregroundStyle(.secondary)
                        }
                    } icon: {
                        student.viewImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .cornerRadius(8)
                            
                    }
                }
            }
            .navigationTitle("Students")
        }
    }
}

struct ClassView: View {
    
    let student: StudentEntity
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(student.viewClasses) { classEntity in
                    NavigationLink {
                        StudentInClassView(classEntity: classEntity)
                    } label: {
                        classEntity.viewImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(alignment: .bottom) {
                                Text(classEntity.viewSubject)
                                    .foregroundStyle(.primary)
                                    .padding(4)
                                    .background(Color.white.opacity(0.6))
                                    .cornerRadius(4)
                            }
                            .background(Color.black)
                            .cornerRadius(16)
                    }
                    
                }
            }
            .padding()
        }
        .navigationTitle("Classes for \(student.viewName)")
    }
}

struct StudentInClassView: View {
    let classEntity: ClassEntity
    
    var body: some View {
        
        List(classEntity.viewStudents) { student in
            Label {
                VStack(alignment: .leading) {
                    Text(student.viewName)
                        .font(.title2.width(.condensed).bold())
                }
            } icon: {
                student.viewImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Students In \(classEntity.viewSubject)")
    }
}

#Preview {
    Relationships_ManyToMany()
        .environment(\.managedObjectContext, SchoolContainer(forPreview: true).viewContext)
}
