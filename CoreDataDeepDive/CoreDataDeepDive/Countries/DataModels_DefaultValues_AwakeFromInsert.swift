//
//  DataModels_DefaultValues_AwakeFromInsert.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct DataModels_DefaultValues_AwakeFromInsert: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    var body: some View {
        VStack {
            Button("Add Brazil") {
                let country = CountryEntity(context: moc)
                
                country.name = "Brazil"
                
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                    moc.delete(country)
                }
            }
            List(countries) { country in
                VStack(alignment: .leading) {
                    Text(country.viewName)
                    Text(country.id?.uuidString ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
            }
        }
        .font(.title)
    }
}

#Preview {
    DataModels_DefaultValues_AwakeFromInsert()
        .environment(\.managedObjectContext, CountriesContainer(forPreview: true).persistentContainer.viewContext)
}
