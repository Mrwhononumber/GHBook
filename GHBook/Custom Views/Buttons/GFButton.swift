//
//  GFButton.swift
//  GHBook
//
//  Created by Basem Elkady on 4/2/25.
//

import UIKit

class GFButton: UIButton {
    
    // MARK: - Initializers


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor:UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    
    // MARK: - Configuration
    
    
    /// Sets up the button's appearance and layout constraints
    private func configure() {
        layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
