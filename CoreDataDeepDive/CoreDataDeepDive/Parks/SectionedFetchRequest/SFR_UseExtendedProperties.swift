//
//  SFR_UseExtendedProperties.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 03/12/25.
//

import SwiftUI

struct SFR_UseExtendedProperties: View {
    @SectionedFetchRequest<String, ParkEntity>(sectionIdentifier: \.viewCountry, sortDescriptors: [SortDescriptor(\.country)]) private var parks
    
    var body: some View {
        NavigationStack {
            List(parks) { section in
                Section {
                    ForEach(section) { park in
                        HStack {
                            Image(uiImage: park.viewImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .cornerRadius(8)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(park.viewName)
                                    .font(.title2)
                                Text(park.viewLocation)
                                    .fontWeight(.light)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                } header: {
                    Text(section.id)
                }
            }
            .headerProminence(.increased)
            .listStyle(.insetGrouped)
            .navigationTitle("Parks")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SFR_UseExtendedProperties()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
