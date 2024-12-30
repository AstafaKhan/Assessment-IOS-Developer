//
//  CollectionViewDD+ProductListVC.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

// MARK: - CollectionView DataSource and Delegate for Top Images Carousel
extension ProductListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC else {
            return UICollectionViewCell()
        }
        cell.updateDataInUI(with: self.categoryList[indexPath.item])
        indexPath.row == self.currentCardIndex ? cell.transformToLarge() : cell.transformToStandard()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Implement actions on item selection if needed
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = self.categoryCV.collectionViewLayout as? CustomCollectionFlowLayout else {
            return CGSize(width: 0.0, height: 0.0)
        }
        return flowLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Handle actions during cell display if needed
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        switch scrollView {
        case self.categoryCV:
            self.walletCurrentPage = Int(scrollView.contentOffset.x / width)
        default:
            return
        }
    }
}

// MARK: - ScrollView Delegate Methods
extension ProductListVC {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        switch scrollView {
        case self.categoryCV:
            let currentCell = self.categoryCV.cellForItem(at: IndexPath(row: self.currentCardIndex, section: 0))
            currentCell?.transformToStandard()
        default:
            return
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView == self.categoryCV else { return }
        targetContentOffset.pointee = scrollView.contentOffset
        
        guard let flowLayout = self.categoryCV.collectionViewLayout as? CustomCollectionFlowLayout else { return }
        let cellWidthIncludingSpacing = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        let offset = targetContentOffset.pointee
        let horizontalVelocity = velocity.x
        
        var selectedIndex = self.currentCardIndex
        
        switch horizontalVelocity {
        case _ where horizontalVelocity > 0:
            selectedIndex = self.currentCardIndex + 1
        case _ where horizontalVelocity < 0:
            selectedIndex = self.currentCardIndex - 1
        case _ where horizontalVelocity == 0:
            selectedIndex = Int(round((offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing))
        default:
            break
        }
        
        let safeIndex = max(0, min(selectedIndex, self.categoryList.count - 1))
        let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
        flowLayout.collectionView?.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        
        let previousSelectedIndexPath = IndexPath(row: self.currentCardIndex, section: 0)
        let previousSelectedCell = self.categoryCV.cellForItem(at: previousSelectedIndexPath)
        let nextSelectedCell = self.categoryCV.cellForItem(at: selectedIndexPath)
        
        previousSelectedCell?.transformToStandard()
        nextSelectedCell?.transformToLarge()
        self.currentCardIndex = selectedIndexPath.row
    }
}
