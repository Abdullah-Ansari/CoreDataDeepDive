//
//  PreviewingData_Intro.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 30/11/25.
//

import SwiftUI

struct PreviewingData_Intro: View {
    
    @FetchRequest(sortDescriptors: []) var friends: FetchedResults<FriendEntity>
    
    var body: some View {
        
        List(friends) { friend in
            Text(friend.firstName ?? "")
        }
        .font(.title)
    }
}

#Preview {
    PreviewingData_Intro()
        .environment(
            \.managedObjectContext, 
             FriendsContainer(forPreview: true).persistentContainer.viewContext
        )
}
