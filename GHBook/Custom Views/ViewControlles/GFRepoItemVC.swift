//
//  GFRepoItemVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/7/25.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
   
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    // MARK: - Configuration

    
    private func configureItems() {
        itemInfoOne.set(item: .repos, withCount: user.publicRepos)
        itemInfoTwo.set(item: .gists, withCount: user.publicGists ?? 0)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    // MARK: - Actions

    /// Notifies delegate to open the user's GitHub profile
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}


