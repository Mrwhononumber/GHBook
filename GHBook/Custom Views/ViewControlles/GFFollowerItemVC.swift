//
//  GFFollowerItemVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/7/25.
//


import UIKit

/// Item info view controller customized for displaying follower statistics
/// Includes an action button to navigate to the user's followers list
class GFFollowerItemVC: GFItemInfoVC {
   
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    //MARK: - Configuration
    
    
    private func configureItems() {
        itemInfoOne.set(item: .followers, withCount: user.followers)
        itemInfoTwo.set(item: .following, withCount: user.following )
        actionButton.set(backgroundColor: .systemGreen , title: "Get followers")
    }
   
    
    //MARK: - Actions
    
    /// if the user has followers it Dismiss the view and notify the delegate
    /// otherwise shows an alert
    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
  
