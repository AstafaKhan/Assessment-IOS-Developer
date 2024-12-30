//
//  UITableViewDD+ProductListVC.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

// MARK: - UITableView DataSource and Delegate for Product Listing with Search Bar in Section Header
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTVC.className) as? ProductTVC else {
            return UITableViewCell()
        }
        cell.updateDataInCell(with: self.filterList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchBarTVH.className) as? SearchBarTVH else {
            return UIView()
        }
        view.searchBar.delegate = self
        return view
    }
}

// MARK: - UISearchBarDelegate
extension ProductListVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter the dataList based on the user input
        self.filterList = searchText.isEmpty
            ? self.productList
            : self.productList.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        self.productListTableView.reloadData()
    }
}
