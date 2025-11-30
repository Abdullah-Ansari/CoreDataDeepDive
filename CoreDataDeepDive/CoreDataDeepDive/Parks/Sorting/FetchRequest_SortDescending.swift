//
//  FetchRequest_SortDescending.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct FetchRequest_SortDescending: View {
    
    @FetchRequest<ParkEntity>(sortDescriptors: [
        SortDescriptor(\.country, order: .reverse),
        SortDescriptor(\.rating, order: .forward)
    ])
    
    /*
     
     country will display in reverse order, and
     rating will display in ascending order.
     */
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
        }
    }
}

#Preview {
    FetchRequest_SortDescending()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
