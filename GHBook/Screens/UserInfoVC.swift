//
//  UserInfoVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/4/25.
//

import UIKit
import SafariServices

/// Delegate protocol for handling user actions from the UserInfoVC
protocol UserInfoVCDelegate: AnyObject {
    /// Called when the user requests to view followers list for curent user
    func didRequestFollowers(for user:User)
}

/// displays detailed GitHub user
class UserInfoVC: UIViewController {
    
    // MARK: - UI Elements
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    // MARK: - Properties
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    // MARK: - Setup
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    // MARK: - Networking
    
    /// Fetches user info and configures the screen with relevant UI components
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success (let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
                
            case .failure (let error):
                self.presentGFAlertOnMainThread(title: "Opss", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    // MARK: - UI Configuration
    
    /// Adds child view controllers to the screen with the fetched user data
    private func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "On Github since \(user.createdAt.formatToGFDate() ?? "")"
    }
    
    
    private func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 20
        let itemViewHeight:CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view .leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view .trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    /// Embeds a child view controller inside a container view
    private func add(childVC:UIViewController, to containerView:UIView ) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    // MARK: - Actions
    
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}


// MARK: - GFItemVC Delegate


extension UserInfoVC: GFItemVCDelegate {
    
    /// Opens the GitHub profile in Safari
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title:  "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    /// Triggers delegate to fetch and update the followers list in (FollowerListVC)
    func didTapGetFollowers(for user: User) {
        delegate.didRequestFollowers(for: user)
    }
}
