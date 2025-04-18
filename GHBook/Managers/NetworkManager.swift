//
//  NetworkManager.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import UIKit

/// A singleton class responsible for making network requests to the GitHub API
class NetworkManager {
    
    // MARK: - Properties
    
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    
    //MARK: - Initializer
    
    
    private init() {}
    
    
    // MARK: - Network Methods
    
    /// Fetches a list of followers for the specified username
    func getFollowers(for userName: String, page: Int, completed: @escaping (Result <[Follower]?, GFError>) -> Void)  {
        let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    
    /// Fetches detailed user information for the specified username
    func getUserInfo(for userName: String, completed: @escaping (Result <User, GFError>) -> Void)  {
        let endPoint = baseUrl + "\(userName)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
}
