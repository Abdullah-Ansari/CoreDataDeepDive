//
//  ParksDataModelExtension.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import UIKit

extension ParkEntity {
    
    var viewImage: UIImage {
        if let data = image, let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "photo")!
    }
    
    var viewName: String {
        return name ?? "[No Park Name]"
    }
    
    var viewRegion: String {
        return region ?? "N/A"
    }
    
    var viewCountry: String {
        return country ?? "N/A"
    }
    
    var viewLocation: String {
        return viewRegion + ", " + viewCountry
    }
    
    var viewRating: String {
        return "\(rating).circle.fill"
    }
    
}
