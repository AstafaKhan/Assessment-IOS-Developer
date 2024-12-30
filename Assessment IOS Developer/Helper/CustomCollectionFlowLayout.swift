//
//  CustomCollectionFlowLayout.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

class CustomCollectionFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        // Scroll direction set to horizontal
        scrollDirection = .horizontal
        
        // Ensure width and height are properly unwrapped, providing a fallback
        let collectionViewWidth = collectionView.frame.width
        let collectionViewHeight = collectionView.frame.height
        
        itemSize = CGSize(width: collectionViewWidth - 80, height: collectionViewHeight - 30)
        
        let peekingItemWidth = itemSize.width / 25
        let horizontalInsets = (collectionViewWidth - itemSize.width) / 2
        
        // Set content insets for centering the collection view
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInsets, bottom: 0, right: horizontalInsets)
        
        // Adjust line spacing based on inset and peeking width
        minimumLineSpacing = horizontalInsets - peekingItemWidth
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func transformToLarge() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
    }
    
    func transformToStandard() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
