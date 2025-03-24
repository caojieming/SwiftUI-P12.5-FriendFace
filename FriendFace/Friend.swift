//
//  Friend.swift
//  FriendFace
//
//  Created by James Cao on 1/21/25.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
