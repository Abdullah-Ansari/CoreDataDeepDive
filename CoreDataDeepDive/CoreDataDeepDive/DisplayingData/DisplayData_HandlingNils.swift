//
//  DisplayData_HandlingNils.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct DisplayData_HandlingNils: View {
    
    @FetchRequest(sortDescriptors: []) private var books: FetchedResults<BookEntity>
    
    var body: some View {
        List(books) { book in
            VStack(alignment: .leading, spacing: 12) {
                Image(uiImage: book.viewCover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack {
                    Text(book.viewTitle)
                        .font(.title2)
                    Spacer()
                    Image(systemName: book.viewAvailability)
                }
                Text(book.viewLastUpdated)
                Text(book.viewPages)
                Text(book.viewPrice)
                Link(
                    destination: book.viewUrl,
                    label: {
                        Text("Learn More")
                    })
                Text(book.viewBookId)
                    .font(.caption2)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    DisplayData_HandlingNils()
        .environment(\.managedObjectContext, BooksContainer(forPreview: true).persistentContainer.viewContext)
}
