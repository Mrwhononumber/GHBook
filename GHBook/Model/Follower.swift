//
//  Follower.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import Foundation

/// A model representing a GitHub follower
struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
}
