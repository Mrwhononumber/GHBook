//
//  SceneDelegate.swift
//  GHBook
//
//  Created by Basem Elkady on 4/2/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

  
    //MARK: - Scene Lifecycle
    
    
    /// Sets up the window and root view controller for the app
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()   // Set root view controller
        window?.makeKeyAndVisible()                  // Make window key and visible
        
        configureNavigationBar()                    // Customize global nav bar appearance
    }
    
    
    //MARK: - Tab Bar Setup
    
    /// Creates and configures the main tab bar controller with its view controllers
    private func createTabBar() -> UITabBarController {
        
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .green
        
    
        tabBar.viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
        
        return tabBar
    }
    
    /// Wraps the Search screen inside a navigation controller
    private func createSearchNavigationController() -> UINavigationController {
        
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
        
    }
    
    /// Wraps the Favorites screen inside a navigation controller.
    private func createFavoritesNavigationController() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
    
    // MARK: - Global Appearance
    
    /// Sets the global navigation bar tint color
    private func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemGreen
    }
}

