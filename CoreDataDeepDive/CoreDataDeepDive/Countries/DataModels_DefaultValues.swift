//
//  DataModels_DefaultValues.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct DataModels_DefaultValues: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    @State private var newCountry = ""
    var body: some View {
        
        VStack {
            TextField("new country", text: $newCountry)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            HStack(spacing: 80) {
                Button("Add Nil") {
                    let country = CountryEntity(context: moc)
                    
                    country.name = newCountry.isEmpty ? nil : newCountry
                    
                    do {
                        try moc.save()
                        newCountry = ""
                    } catch {
                        print(error.localizedDescription)
                        moc.delete(country)
                    }
                }
                
                Button("Add Nothing") {
                    let country = CountryEntity(context: moc)
                    
                    if newCountry.isEmpty == false {
                        country.name = newCountry
                    }
                    
                    do {
                        try moc.save()
                        newCountry = ""
                    } catch {
                        print(error.localizedDescription)
                        moc.delete(country)
                    }
                }
            }
            
            List(countries) { country in
                Text(country.viewName)
                
            }
        }
    }
}

#Preview {
    DataModels_DefaultValues()
        .environment(\.managedObjectContext, CountriesContainer(forPreview: true).persistentContainer.viewContext)
}
