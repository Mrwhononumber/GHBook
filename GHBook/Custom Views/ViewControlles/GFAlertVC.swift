//
//  GFAlertVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/2/25.
//

import UIKit

class GFAlertVC: UIViewController {
    
    
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButtton = GFButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let pading: CGFloat = 20
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(_colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        

     
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 280),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
        
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong!"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: pading),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: pading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -pading),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureActionButton() {
        containerView.addSubview(actionButtton)
        actionButtton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButtton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButtton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -pading),
            actionButtton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -pading),
            actionButtton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: pading),
            actionButtton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -pading),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: pading),
            messageLabel.bottomAnchor.constraint(equalTo: actionButtton.topAnchor, constant: -12)
            
            
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
        
    }
    

    

}
