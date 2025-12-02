//
//  FetchRequest_MOC_Count.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 02/12/25.
//

import SwiftUI

struct FetchRequest_MOC_Count: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var parksCount = 0
    
    var body: some View {
        NavigationStack {
            List {
                VStack {
                    Text("Parks")
                        .badge(parksCount)
                }
            }
            .task {
                if let count = try? moc.count(for: ParkEntity.fetchRequest()) {
                    parksCount = count
                }
            }
            .navigationTitle("Details")
        }
    }
}

#Preview {
    FetchRequest_MOC_Count()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
