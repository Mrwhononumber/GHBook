//
//  User.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import Foundation

/// A model representing a GitHub user
struct User: Codable {
    let login: String
    let avatarUrl: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int?
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
