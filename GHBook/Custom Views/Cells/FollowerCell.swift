//
//  FollowerCell.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import UIKit

/// A custom collection view cell that displays a GitHub user's avatar and username in the Followers list
class FollowerCell: UICollectionViewCell {
    
    // MARK: - Properties

    
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
   
    
    // MARK: - Initializers

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the cell with a Follower's username and avatar image
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        
        // Reset to placeholder to avoid showing wrong image during cell reuse
        avatarImageView.image = UIImage(named: "avatar-placeholder")
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    
    // MARK: - Configuration

    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
