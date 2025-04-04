//
//  UIHelper.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView ) -> UICollectionViewFlowLayout {
        let width = view.bounds.width // The whole screen width
        let padding: CGFloat = 12
        let minimumItemSpacing:CGFloat = 10 // space between cells
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40 )
        
        return flowLayout
        
    }
}
