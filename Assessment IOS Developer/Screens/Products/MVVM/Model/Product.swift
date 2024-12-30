//
//  Product.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import Foundation

// MARK: - Product Model
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating Model
struct Rating: Codable {
    let rate: Double
    let count: Int
}
