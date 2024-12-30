//
//  ProductEndPoint.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import Foundation


enum ProductEndPoint {
    case productsbasedOnCategory(categoryName: String)
}

extension ProductEndPoint: EndPointType {

    var path: String {
        switch self {
        case .productsbasedOnCategory(let categoryName):
            return "products/category/\(categoryName)"
            
        }
    }

    var baseURL: String {
        switch self {
        case .productsbasedOnCategory:
            return "https://fakestoreapi.com/"
        
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .productsbasedOnCategory:
            return .get
        
        }
    }

    var body: Encodable? {
        switch self {
        case .productsbasedOnCategory:
            return nil
        
        }
    }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
