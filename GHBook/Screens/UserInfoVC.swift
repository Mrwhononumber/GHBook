//
//  UserInfoVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/4/25.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButtone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButtone
        print ("the username is: \(username)")
        
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else { return }
            switch result {
             
            case .success (let user):
                print(user)
                
            case .failure (let error):
                self.presentGFAlertOnMainThread(title: "Opss", message: error.rawValue, buttonTitle: "Ok")
            }
        }
 
    }
    

    @objc func dismissVC() {
   dismiss(animated: true)
    }

}
