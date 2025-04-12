//
//  GFItemInfoVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/7/25.
//

import UIKit

// MARK: - Delegate Protocol


protocol GFItemVCDelegate: AnyObject {
    
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}


// MARK: - Reusable Base Class


class GFItemInfoVC: UIViewController {
    
    
    // MARK: - UI Elements
    
    
    let stackView = UIStackView()
    let itemInfoOne = GFItemInfoView()
    let itemInfoTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    
    // MARK: - Properties
    
    
    var user: User!
    weak var delegate: GFItemVCDelegate!
    
    
    // MARK: - Initializers

    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil )
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
   
    // MARK: - Configuration
    
    
   private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    
   private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoOne)
        stackView.addArrangedSubview(itemInfoTwo)
    }
    
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50 ),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    /// To be overridden by subclasses for custom action behavior
    @objc func actionButtonTapped() {}
}
