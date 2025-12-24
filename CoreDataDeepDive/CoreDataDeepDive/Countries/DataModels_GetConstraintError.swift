//
//  DataModels_GetConstraintError.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI
import CoreData

struct DataModels_GetConstraintError: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    @State private var newCountry = ""
    @State private var validationError = ""
    @State private var duplicatesError = ""
    
    var body: some View {
        VStack {
            TextField("New Country", text: $newCountry)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Add") {
                validationError = ""
                duplicatesError = ""
                let country = CountryEntity(context: moc)
                country.name = newCountry
                do {
                    try moc.save()
                    newCountry = ""
                } catch let e as CocoaError {
                    let errorDictionary = e.userInfo
                    if let conflictList = errorDictionary[NSPersistentStoreSaveConflictsErrorKey] {
                        let constraintConflicts = conflictList as! [NSConstraintConflict]
                        
                        for conflict in constraintConflicts {
                            validationError = "Constraint violation(s) from: " + conflict.constraint.joined(separator: ", ")
                            var duplicate: [String] = []
                            for (propertName, value) in conflict.constraintValues {
                                duplicate.append("The property name should have unique value, '\(value)' already exists.")
                            }
                            duplicatesError = duplicate.joined(separator: "\n")
                        }
                    }
                    moc.delete(country)
                } catch {
                    validationError = error.localizedDescription
                }
            }
        }
        Text(validationError)
            .foregroundStyle(.red)
        Text(duplicatesError)
            .foregroundStyle(.red)
        List(countries) { country in
            Text(country.viewName)
        }
    }
}

#Preview {
    DataModels_GetConstraintError()
        .environment(\.managedObjectContext, CountriesContainer(forPreview: true).persistentContainer.viewContext)
}
