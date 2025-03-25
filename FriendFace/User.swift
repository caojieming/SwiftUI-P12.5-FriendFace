//
//  User.swift
//  FriendFace
//
//  Created by James Cao on 1/21/25.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    
    // changed "let" to "private(set) var" to remove warnings
    private(set) var id: String
    private(set) var isActive: Bool
    private(set) var name: String
    private(set) var age: Int
    private(set) var company: String
    private(set) var email: String
    private(set) var address: String
    private(set) var about: String
    private(set) var registered: Date
    private(set) var tags: [String]
    private(set) var friends: [Friend]
    
    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
    
    
    // all code below used to associate json vars with code vars
    enum CodingKeys: String, CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        
        let stringRegistered = try container.decode(String.self, forKey: .registered)
        self.registered = ISO8601DateFormatter().date(from: stringRegistered) ?? Date.distantPast
        
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(ISO8601DateFormatter().string(from: self.registered), forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.friends, forKey: .friends)
    }
}


