//
//  NetworkManager.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for userName: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void)  {
        let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, "this username created invalid request. please try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
          
            if let _ = error {
                completed(nil, "Unable to complete request. check your internet connection")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. please try again")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server is invalid. please try again")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data received from the server is invalid. please try again")
            }
            
        }
        
        task.resume()
    }
}
