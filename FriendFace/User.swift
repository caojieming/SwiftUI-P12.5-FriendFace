//
//  User.swift
//  FriendFace
//
//  Created by James Cao on 1/21/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
}


