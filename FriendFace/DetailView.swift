//
//  DetailView.swift
//  FriendFace
//
//  Created by James Cao on 1/23/25.
//

import SwiftUI

struct DetailView: View {
    
    let user: User
    
    var body: some View {
        List {
            // general user info
            Section {
                Text("Registered: \(user.formattedDate)")
                Text("Age: \(user.age)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("Works for: \(user.company)")
            } header: {
                Text("Basic Info")
            }
            
            // user description/introduction
            Section {
                Text(user.about)
            } header: {
                Text("About")
            }
            
            // user's friends
            Section {
                ForEach(user.friends) { friend in 
                    Text(friend.name)
                }
            } header: {
                Text("Friends")
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
