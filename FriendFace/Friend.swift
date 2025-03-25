//
//  Friend.swift
//  FriendFace
//
//  Created by James Cao on 1/21/25.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    
    // like User, changed "let" to "private(set) var" to remove warnings
    private(set) var id: String
    private(set) var name: String
    
    
    // all code below used to associate json vars with code vars
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
