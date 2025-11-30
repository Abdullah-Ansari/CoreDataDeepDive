//
//  FetchRequest_Animation_Other_2.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct FetchRequest_Animation_Other_2: View {
    @State private var justCanada = false
    @FetchRequest<ParkEntity>(sortDescriptors: [])
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
                        withAnimation(.easeInOut(duration: 2)) {
                            justCanada.toggle()
                            parks.nsPredicate = justCanada ? NSPredicate(format: "country == 'Canada'") : nil
                        }
                        
                    } label: {
                        Image(systemName: justCanada ? "globe.americas.fill" : "globe.americas")
                    }
                }
            }
        }
    }
}

#Preview {
    FetchRequest_Animation_Other_2()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
