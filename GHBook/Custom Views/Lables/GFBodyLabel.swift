//
//  GFBodyLabel.swift
//  GHBook
//
//  Created by Basem Elkady on 4/2/25.
//

import UIKit

/// A custom UILabel subclass styled for body text
class GFBodyLabel: UILabel {

    //MARK: - Initializers
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializes the label with a specific text alignment
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
   
    //MARK: - Configuration
    
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
