//
//  Relationships_ParentChild.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 24/12/25.
//

import SwiftUI

struct Relationships_ParentChild: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: []) private var manufacturers
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                NavigationLink(destination: {
                    
                    List(manufacturer.viewAutoEntities) { auto in
                        Text(auto.model ?? "")
                        
                    }
                }, label: {
                    Text(manufacturer.name ?? "")
                })
                
            }
            .navigationTitle("Parent-Child")
        }
    }
}

#Preview {
    Relationships_ParentChild()
        .environment(\.managedObjectContext, AutosContainer(forPreview: true).persistent.viewContext)
}
