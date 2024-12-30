//
//  ImageManager.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import UIKit

class ImageLoader {

    // Simple in-memory cache with optional expiration time
    private var imageCache = [String: UIImage]()
    private var cacheTimestamps = [String: Date]()
    
    private let cacheExpirationDuration: TimeInterval = 3600 // 1 hour
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        // Check if the image is already cached and not expired
        if let cachedImage = imageCache[url.absoluteString], let cachedTimestamp = cacheTimestamps[url.absoluteString], Date().timeIntervalSince(cachedTimestamp) < cacheExpirationDuration {
            completion(cachedImage)
            return
        }

        // Image is not cached or has expired, start downloading
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle error
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // Convert data to UIImage
            if let image = UIImage(data: data) {
                // Cache the image with a timestamp
                self.imageCache[url.absoluteString] = image
                self.cacheTimestamps[url.absoluteString] = Date()
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
