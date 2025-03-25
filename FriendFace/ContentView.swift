//
//  ContentView.swift
//  FriendFace
//
//  Created by James Cao on 1/20/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    //@State private var users = [User]()
    @Query var users : [User]
    
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
//                if let retrievedUsers = await getUsers() {
//                    users = retrievedUsers
//                }
                await downloadJson()
            }
        } // NavigationView
    }
    
    // retrieve json data from url, online use
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
    
    // retrieve + download json data from url permanently
    func downloadJson() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                fatalError("Invalid URL.")
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if users.isEmpty {
                guard let decodedResponse = try? decoder.decode([User].self, from: data) else {
                    fatalError("Failed to decode data.")
                }
                try? modelContext.delete(model: User.self)
                for user in decodedResponse {
                    modelContext.insert(user)
                }
            }
        } catch {
            fatalError("Failed to decode data.")
        }
        
    }
        
    
}

#Preview {
    ContentView()
}
