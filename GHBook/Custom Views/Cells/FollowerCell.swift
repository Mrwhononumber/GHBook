//
//  FollowerCell.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower:Follower) {
        usernameLabel.text = follower.login
    }
    
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let pading: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: pading),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: pading),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -pading),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: pading),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -pading),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
                                                    
            
        ])
    }
}
