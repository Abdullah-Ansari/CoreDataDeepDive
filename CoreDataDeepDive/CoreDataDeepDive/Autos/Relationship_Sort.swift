//
//  Relationship_Sort.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct Relationship_Sort: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                Section {
                    ForEach(manufacturer.viewSortAutos) { auto in
                        Text(auto.viewModel)
                    }
                } header: {
                    Text(manufacturer.viewName)
                }
                
            }
            .navigationTitle("Sorted")
        }
    }
}

#Preview {
    Relationship_Sort()
        .environment(\.managedObjectContext, AutosContainer(forPreview: true).persistent.viewContext)
}
