//
//  PersistenceManager.swift
//  GHBook
//
//  Created by Basem Elkady on 4/9/25.
//

import Foundation

/// Represents the type of persistence action to perform
enum PersistanceActionType {
    case add, remove
}

/// Manages storing and retrieving favorites using UserDefaults
enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "Favorites"
    }
    
    
    //MARK: - Favorites Persistance Methods
    
    /// Updates the favorites list by adding or removing a follower
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GFError?) -> Void) {
        retriveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrivedFavorites.append(favorite)
                    
                case .remove:
                    retrivedFavorites.removeAll { $0.login == favorite.login }
                }
                
                
                completed(save(favorites: retrivedFavorites))
                
            case .failure(let error):
                completed(error )
            }
        }
    }
    
    /// Retrieves the stored list of favorite followers
    static func retriveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    /// Saves the favorites array to UserDefaults
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
