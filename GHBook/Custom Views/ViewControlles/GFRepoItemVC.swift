//
//  GFRepoItemVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/7/25.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(item: .repos, withCount: user.publicRepos)
        itemInfoTwo.set(item: .gists, withCount: user.publicGists ?? 0)
        actionButton.set(backgroundColr: .systemPurple, title: "Github Profile")
    }
}


