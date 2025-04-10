//
//  FavoritesListVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/2/25.
//

import UIKit

class FavoritesListVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        PersistenceManager.retriveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
    



}
