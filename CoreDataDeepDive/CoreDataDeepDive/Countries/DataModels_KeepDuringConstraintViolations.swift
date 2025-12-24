//
//  DataModels_KeepDuringConstraintViolations.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI
import CoreData

struct DataModels_KeepDuringConstraintViolations: View {
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
                try! moc.save()
                newCountry = ""
            }
            
            List(countries) { country in
                HStack {
                    Text(country.viewName)
                    Spacer()
                    Text(country.viewLastVisited)
                        .foregroundStyle(.gray)
                }
            }
        }
        .onAppear() {
            // keep the origional data object.
            moc.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}

#Preview {
    DataModels_KeepDuringConstraintViolations()
        .environment(
            \.managedObjectContext,
             CountriesContainer(
                forPreview: true
             ).persistentContainer.viewContext)
}
