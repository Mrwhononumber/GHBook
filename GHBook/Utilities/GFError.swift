//
//  ErrorMessage.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUsername = "this username created invalid request. please try again"
    case unableToComplete = "Unable to complete request. check your internet connection"
    case invalidResponse = "Invalid response from the server. please try again"
    case invalidData = "The data received from the server is invalid. please try again"
    
    
}
