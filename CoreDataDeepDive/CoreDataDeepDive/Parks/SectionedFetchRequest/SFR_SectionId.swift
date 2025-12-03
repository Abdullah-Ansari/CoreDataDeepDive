//
//  SFR_SectionId.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 03/12/25.
//

import SwiftUI

struct SFR_SectionId: View {
    
    @SectionedFetchRequest<String?, ParkEntity>(
        sectionIdentifier: \.country,
        sortDescriptors: [SortDescriptor(\.country, order: .reverse)]
    ) private var parks
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(parks) { section in
                        LabeledContent(section.id!, value: "\(section.count)")
                    }
                } footer: {
                    LabeledContent("Country Count", value: "\(parks.count)")
                }
            }
            .navigationTitle("Parks Count")
        }
    }
}

#Preview {
    SFR_SectionId()
        .environment(\.managedObjectContext, ParksContainer(forPreview: true).persistentContainer.viewContext)
}
