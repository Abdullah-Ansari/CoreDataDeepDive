//
//  FetchRequest_Animation.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct FetchRequest_Animation: View {
    @State private var searchText = ""
    @FetchRequest<ParkEntity>(sortDescriptors: [], animation: .easeInOut(duration: 0.2))
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
            .onChange(of: searchText) { _, newSearchText in
                parks.nsPredicate = newSearchText.isEmpty ? nil : NSPredicate(format: "name CONTAINS %@", newSearchText)
            }
        }
    }
}

#Preview {
    FetchRequest_Animation()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
