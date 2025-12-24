//
//  MOC_UpdateHasChanges.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct MOC_UpdateHasChanges: View {
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    var body: some View {
        NavigationStack {
            List(countries) { country in
                NavigationLink {
                    EditCountry(countryEntity: country)
                } label: {
                    Text(country.viewName)
                }
                
            }
            .navigationTitle("Countries")
        }
    }
}

struct EditCountry: View {
    let countryEntity: CountryEntity
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var moc
    
    @State private var country = ""
    
    var body: some View {
        VStack {
            TextField("country", text: $country)
                .padding()
                .border(.gray.opacity(0.5), width: 0.5)
            
            Button("Save") {
                if countryEntity.name != country {
                    countryEntity.name = country
                }
                
                if moc.hasChanges {
                    try? moc.save()
                }
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .onAppear() {
            country = countryEntity.name ?? ""
        }
    }
}


#Preview {
    MOC_UpdateHasChanges()
        .environment(\.managedObjectContext, CountriesContainer(forPreview: true).persistentContainer.viewContext)
}
