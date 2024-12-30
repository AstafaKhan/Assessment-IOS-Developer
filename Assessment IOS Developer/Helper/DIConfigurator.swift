//
//  DIConfigurator.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

final class DIConfigurator {

    // Singleton instance
    static let shared = DIConfigurator()

    // Private initializer to prevent instantiation
    private init() {}

    // MARK: - Register TableView Header Xib
    func registerHeaderView(nib: NibBoard, in tableView: UITableView) {
        tableView.register(UINib(nibName: nib.rawValue, bundle: nil), forHeaderFooterViewReuseIdentifier: nib.rawValue)
    }

    // MARK: - Register TableView Cell
    func registerTableCell(nib: NibBoard, in tableView: UITableView) {
        tableView.register(UINib(nibName: nib.rawValue, bundle: nil), forCellReuseIdentifier: nib.rawValue)
        tableView.tableFooterView = UIView() // Avoid empty rows at the bottom
    }

    // MARK: - Register Collection Cell Xib
    func registerCollectionCell(nib: NibBoard, in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: nib.rawValue, bundle: nil), forCellWithReuseIdentifier: nib.rawValue)
    }
}
