//
//  FetchRequest_GoingBeyond.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 02/12/25.
//

import SwiftUI

struct FetchRequest_GoingBeyond: View {
    @FetchRequest(fetchRequest: ParkEntity.firstFive) private var parks
    
    var body: some View {
        NavigationStack {
            List(parks) { park in
                HStack {
                    Image(uiImage: park.viewImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
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
            .safeAreaInset(edge: .bottom) {
                VStack {
                    Divider()
                    Text("Total Parks: \(parks.count)")
                }
                .background(.bar)
            }
            .navigationTitle("Parks")
        }
    }
}

#Preview {
    FetchRequest_GoingBeyond()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
