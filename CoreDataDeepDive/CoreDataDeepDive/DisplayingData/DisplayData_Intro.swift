//
//  DisplayData_Intro.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct DisplayData_Intro: View {
    
    @FetchRequest(sortDescriptors: []) private var books: FetchedResults<BookEntity>
    
    var body: some View {
        List(books) { book in
            VStack(alignment: .leading, spacing: 12) {
                getImage(imageData: book.cover)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    Text(book.title ?? "")
                        .font(.title2)
                    Spacer()
                    Image(systemName: book.available ? "checkmark" : "xmark")
                }
                
                Text(book.lastUpdated?.formatted(date: .numeric, time: .omitted) ?? "N/A")
                Text("Pages: \(book.pages)")
                Text((book.price ?? 0) as Decimal, format: .currency(code: "USD"))
                Link(destination: book.url ?? URL(string: "https://onlyfortest.com/")!) {
                    Text("Learn More")
                }
                Text(book.bookId?.uuidString ?? "")
            }
            .padding(.vertical)
        }
    }
    
    private func getImage(imageData: Data?) -> Image {
        if let data = imageData, let image = UIImage(data: data) {
            return Image(uiImage: image)
        }
        return Image(systemName: "photo.fill")
    }
}

#Preview {
    DisplayData_Intro()
        .environment(\.managedObjectContext, BooksContainer(forPreview: true).persistentContainer.viewContext)
}
