//
//  GFSecondaryTitleLabel.swift
//  GHBook
//
//  Created by Basem Elkady on 4/6/25.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    
    //MARK: - Initializers
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializes the label with a specific font size
    init(fontSize:CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    
    //MARK: - Configuration
    
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
