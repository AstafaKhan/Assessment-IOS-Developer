//
//  ProductTVC.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

final class ProductTVC: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public Methods
    func updateDataInCell(with product: Product) {
        // Set the product name
        self.productName?.text = product.title

        // Load the product image
        if let imageUrl = URL(string: product.image) {
            let imageLoader = ImageLoader()
            imageLoader.downloadImage(url: imageUrl) { [weak self] image in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.productImageView.image = image ?? UIImage(named: "placeholder") // Use placeholder if image is nil
                }
            }
        } else {
            // Set a placeholder image if URL is invalid
            self.productImageView.image = UIImage(named: "placeholder")
        }
    }
}
