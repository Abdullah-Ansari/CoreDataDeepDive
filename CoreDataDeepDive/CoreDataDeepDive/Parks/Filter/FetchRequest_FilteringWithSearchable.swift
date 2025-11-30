//
//  FetchRequest_FilteringWithSearchable.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct FetchRequest_FilteringWithSearchable: View {
    @State private var searchText = ""
    @FetchRequest<ParkEntity>(sortDescriptors: [])
    private var parks
    
    var body: some View {
        NavigationStack {
            List(parks) { park in
                HStack {
                    Image(uiImage: park.viewImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(park.viewName)
                            .font(.title)
                        Text(park.viewLocation)
                            .fontWeight(.light)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Parks")
            .searchable(text: $searchText)
            .onChange(of: searchText) { _, text in
                parks.nsPredicate = text.isEmpty ? nil : NSPredicate(format: "name CONTAINS %@", text)
            }
        }
    }
}

#Preview {
    FetchRequest_FilteringWithSearchable()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
