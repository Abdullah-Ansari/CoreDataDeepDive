//
//  Relationships_Nested.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct Relationships_Nested: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: []) private var manufacturers
    
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                
                Section {
                    ForEach(manufacturer.viewAutoEntities) { auto in
                        Text(auto.model ?? "")
                    }
                } header: {
                    Text(manufacturer.viewName)
                }
                
            }
            .navigationTitle("Nested")
        }
    }
}

#Preview {
    Relationships_Nested()
        .environment(\.managedObjectContext, AutosContainer(forPreview: true).persistent.viewContext)
}
