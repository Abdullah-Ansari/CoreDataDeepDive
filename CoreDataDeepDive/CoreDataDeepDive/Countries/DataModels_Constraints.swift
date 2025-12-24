//
//  DataModels_Constraints.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct DataModels_Constraints: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    @State private var newCountry = ""
    
    var body: some View {
        VStack {
            TextField("New Country", text: $newCountry)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Add") {
                let country = CountryEntity(context: moc)
                country.name = newCountry
                // duplicate entity will be added but not be persisted.
                // It is adding in the managed object context.
                try? moc.save()
                newCountry = ""
            }
        }
        
        List(countries) { country in
            Text(country.viewName)
        }
    }
}

#Preview {
    DataModels_Constraints()
        .environment(\.managedObjectContext, CountriesContainer(forPreview: true).persistentContainer.viewContext)
}
