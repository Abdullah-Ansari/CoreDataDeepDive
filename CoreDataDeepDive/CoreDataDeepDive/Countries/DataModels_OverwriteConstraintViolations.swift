//
//  DataModels_OverwriteConstraintViolations.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI
import CoreData

struct DataModels_OverwriteConstraintViolations: View {
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
            // new data will override the old one.
            moc.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}

#Preview {
    DataModels_OverwriteConstraintViolations()
}
