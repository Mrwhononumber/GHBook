//
//  GFFollowerItemVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/7/25.
//


import UIKit



class GFFollowerItemVC: GFItemInfoVC {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(item: .followers, withCount: user.followers)
        itemInfoTwo.set(item: .following, withCount: user.following )
        actionButton.set(backgroundColr: .systemGreen , title: "Get followers")
    }
   
    
    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
  
