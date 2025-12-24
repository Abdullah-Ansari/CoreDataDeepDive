//
//  DataModels_NotOptional.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct DataModels_NotOptional: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<AnimalEntity>(sortDescriptors: []) private var animals
    @State private var newAnimal: String = ""
    @State private var requiredError = ""
    
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
                do {
                    // since the name property is not optional.
                    // it will through error, and will handle.
                    try moc.save()
                    newAnimal = ""
                } catch {
                    requiredError = error.localizedDescription.firstUppercased
                    moc.delete(animal)
                }
                
                newAnimal = ""
            }
            Text(requiredError)
                .foregroundStyle(.red)
            List(animals) { animal in
                Text(animal.name ?? "N/A")
                    .foregroundStyle(animal.name == nil ? .red : .primary)
            }
        }
        .font(.title)
    }
}

#Preview {
    DataModels_NotOptional()
        .environment(\.managedObjectContext, AnimalsContainer(forPreview: true).persistent.viewContext)
}


