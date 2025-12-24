//
//  DataModels_Optional_Updates.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct DataModels_Optional_Updates: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<AnimalEntity>(sortDescriptors: []) private var animals
    @State private var animalName: String = ""
    @State private var selectedAnimal: AnimalEntity?
    @State private var requiredError = ""
    
    var body: some View {
        VStack(spacing: 20) {
            List(animals) { animal in
                Text(animal.viewName)
                    .onTapGesture {
                        animalName = animal.viewName
                        selectedAnimal = animal
                    }
            }
            
            TextField("Select animal to edit", text: $animalName)
                .textFieldStyle(.roundedBorder)
                .padding([.horizontal])
            
            Text(requiredError)
                .foregroundStyle(.red)
            
            Button("Update") {
                if let animal = selectedAnimal {
                    let previousValue = animal.viewName
                    animal.name = animalName.isEmpty ? nil : animalName
                    
                    do {
                        try moc.save()
                        selectedAnimal = nil
                        animalName = ""
                        requiredError = ""
                    } catch {
                        requiredError = error.localizedDescription.firstUppercased
                        animal.name = previousValue
                    }
                    
                    
                }
            }
        }
        .font(.title)
    }
}

#Preview {
    DataModels_Optional_Updates()
        .environment(\.managedObjectContext, AnimalsContainer(forPreview: true).persistent.viewContext)
}
