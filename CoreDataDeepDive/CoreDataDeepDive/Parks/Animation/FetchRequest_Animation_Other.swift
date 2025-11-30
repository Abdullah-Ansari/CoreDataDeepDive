//
//  FetchRequest_Animation_Other.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct FetchRequest_Animation_Other: View {
    @State private var justCanada = false
    @FetchRequest<ParkEntity>(sortDescriptors: [], animation: .easeOut(duration: 2))
    private var parks
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(parks) { park in
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
            }
            .padding(.horizontal)
            .navigationTitle("Parks")
            .toolbar {
                ToolbarItem {
                    Button {
                        justCanada.toggle()
                        parks.nsPredicate = justCanada ? NSPredicate(format: "country == 'Canada'") : nil
                    } label: {
                        Image(systemName: justCanada ? "globe.americas.fill" : "globe.americas")
                    }
                }
            }
        }
    }
}

#Preview {
    FetchRequest_Animation_Other()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
