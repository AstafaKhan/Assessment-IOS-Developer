//
//  CategoryCVC.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

final class CategoryCVC: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        categoryImageView.clipsToBounds = true
        categoryImageView.layer.cornerRadius = 25
    }

    // MARK: - Public Methods
    func updateDataInUI(with categoryName: String) {
        categoryImageView.image = UIImage(named: categoryName) ?? UIImage(named: "placeholder") // Fallback placeholder
        categoryNameLabel.text = categoryName.uppercased()
    }
}
