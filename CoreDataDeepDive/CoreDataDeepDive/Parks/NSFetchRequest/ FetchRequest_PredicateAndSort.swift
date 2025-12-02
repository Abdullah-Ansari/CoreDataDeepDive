//
//   FetchRequest_PredicateAndSort.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 02/12/25.
//

import SwiftUI

struct FetchRequest_PredicateAndSort: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var parksCount = 0
    @State private var parkArray: [String] = []
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading) {
                    Text("Parks in United States")
                        .badge(parksCount)
                        .font(.title2.weight(.bold))
                    Text(parkArray, format: .list(type: .and, width: .standard))
                }
            }
            .task {
                let request = ParkEntity.fetchRequest()
                request.predicate = NSPredicate(format: "country CONTAINS %@", "States")
                request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                if let parks = try? moc.fetch(request) {
                    parksCount = parks.count
                    
                    for park in parks {
                        parkArray.append(park.viewName)
                    }
                }
            }
            .navigationTitle("Details")
        }
    }
}

#Preview {
    FetchRequest_PredicateAndSort()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
