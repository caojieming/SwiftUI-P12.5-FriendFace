//
//  ContentView.swift
//  FriendFace
//
//  Created by James Cao on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    Text(user.name)
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if let retrievedUsers = await getUsers() {
                    users = retrievedUsers
                }
            }
        } // NavigationView
    }
    
    // retrieve json data from url
    func getUsers() async -> [User]? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode([User].self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
    
}

#Preview {
    ContentView()
}
