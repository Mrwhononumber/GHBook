//
//  ErrorMessage.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import Foundation


/// Custom app-wide error types for handling common failure cases
enum GFError: String, Error {
    
    case invalidUsername    = "this username created invalid request. please try again"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. please try again"
    case invalidData        = "The data received from the server is invalid. please try again"
    case unableToFavorite   = "Unable to add this user to favorites. Please try again"
    case alreadyInFavorites = "This user is already in favorites"
}
