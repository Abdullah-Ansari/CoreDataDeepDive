//
//  Relationships_SectionedFetchRequest.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct Relationships_SectionedFetchRequest: View {
    
    @SectionedFetchRequest<String?, AutoEntity>(
        sectionIdentifier: \.manufacturerEntity?.name,
        sortDescriptors: [SortDescriptor(\.manufacturerEntity?.name)]) 
    private var autos
    
    var body: some View {
        NavigationStack {
            List(autos) { section in
                Section {
                    ForEach(section) { auto in
                        Text(auto.model ?? "")
                            .font(.title3.weight(.light))
                        
                    }
                } header: {
                    Text(section.id!)
                }
                
            }
            .headerProminence(.increased)
            .navigationTitle("Autos")
        }
    }
}

#Preview {
    Relationships_SectionedFetchRequest()
        .environment(\.managedObjectContext, AutosContainer(forPreview: true).persistent.viewContext)
}
