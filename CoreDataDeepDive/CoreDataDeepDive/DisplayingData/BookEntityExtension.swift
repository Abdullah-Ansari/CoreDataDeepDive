//
//  BookEntityExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import UIKit

extension BookEntity {
    
    var viewCover: UIImage {
        if let data = cover, let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "note.text")!
    }
    
    var viewTitle: String {
        return title ?? "No Book Title"
    }
    
    var viewAvailability: String {
        return available ? "checkmark" : "xmark"
    }
    
    var viewLastUpdated: String {
        return "Last Updated: " + (lastUpdated?.formatted(date: .numeric, time: .omitted) ?? "N/A")
    }
    
    var viewPages: String {
        return "Pages: \(pages)"
    }
    
    var viewPrice: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: price ?? 0)!
    }
    
    var viewUrl: URL {
        return url ?? URL(string: "https://www.bigmountainstudio.com")!
    }
    
    var viewBookId: String {
        return bookId?.uuidString ?? ""
    }
}
