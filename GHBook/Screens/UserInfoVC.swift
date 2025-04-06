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
 
    }
    

    @objc func dismissVC() {
   dismiss(animated: true)
    }

}
