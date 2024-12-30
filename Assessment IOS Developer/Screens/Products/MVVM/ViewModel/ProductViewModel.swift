//
//  ProductViewModel.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import Foundation

final class ProductViewModel {

    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func fetchProducts(for category: String) {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: [Product].self,
            type: ProductEndPoint.productsbasedOnCategory(categoryName: category)
        ) { [weak self] response in
            guard let self = self else { return }
            self.eventHandler?(.stopLoading)
            
            switch response {
            case .success(let products):
//                MARK: - Temporary duplication for scrolling
                self.products = products + products + products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

// MARK: - Event Enum
extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
