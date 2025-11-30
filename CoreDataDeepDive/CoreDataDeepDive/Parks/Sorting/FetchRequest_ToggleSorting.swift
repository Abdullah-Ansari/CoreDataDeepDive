//
//  FetchRequest_ToggleSorting.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct FetchRequest_ToggleSorting: View {
    
    @FetchRequest<ParkEntity>(sortDescriptors: [
        SortDescriptor(\.name)
    ])
    private var parks
    @State private var sortAscending = true
    
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
                        HStack {
                            Text(park.viewName)
                                .font(.title)
                            Spacer()
                            Image(systemName: park.viewRating)
                        }
                        .font(.title)
                        Text(park.viewLocation)
                            .fontWeight(.light)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Parks")
            .toolbar {
                ToolbarItem {
                    Button(action: toggleAction) {
                        Image(systemName: sortAscending ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
                    }
                }
            }
        }
    }
    
    private func toggleAction() {
        sortAscending.toggle()
        parks.sortDescriptors = [
            SortDescriptor(\.name, order: sortAscending ? .forward : .reverse)
        ]
    }
}

#Preview {
    FetchRequest_ToggleSorting()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
