//
//  FirstExampleView.swift
//  CoreDataDeepDive
//
//  Created by Abdullah Ansari on 26/11/25.
//

import SwiftUI

struct FirstExampleView: View {
    
    @FetchRequest(sortDescriptors: []) private var people: FetchedResults<PersonEntity>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            List(people) { person in
                Text(person.name ?? "")
            }
            
            Button("Add Person") {
                let person =  PersonEntity(context: moc)
                person.name = ["Abdullah", "Ajay", "Akash", "Manish", "Divas", "Dharam"].randomElement()
                try? moc.save()
                
            }
        }
        .font(.title)
    }
}

#Preview {
    FirstExampleView()
}
