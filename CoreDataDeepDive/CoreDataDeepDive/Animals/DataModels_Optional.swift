//
//  DataModels_Optional.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct DataModels_Optional: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<AnimalEntity>(sortDescriptors: []) private var animals
    @State private var newAnimal: String = ""
    
    var body: some View {
        VStack {
            TextField("New animal", text: $newAnimal)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Add") {
                let animal = AnimalEntity(context: moc)
               
                if newAnimal.isEmpty == false {
                    animal.name = newAnimal
                }
                
                try? moc.save()
                
                newAnimal = ""
            }
            
            List(animals) { animal in
                Text(animal.name ?? "N/A")
                    .foregroundStyle(animal.name == nil ? .red : .primary)
            }
        }
        .font(.title)
    }
}

#Preview {
    DataModels_Optional()
        .environment(\.managedObjectContext, AnimalsContainer(forPreview: true).persistent.viewContext)
}
