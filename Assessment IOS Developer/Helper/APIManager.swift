//
//  APIManager.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import Foundation

// MARK: - DataError Enum
enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}

// MARK: - ResultHandler Typealias
typealias ResultHandler<T> = (Result<T, DataError>) -> Void

// MARK: - APIManager
final class APIManager {

    static let shared = APIManager()
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler

    init(networkHandler: NetworkHandler = NetworkHandler(), responseHandler: ResponseHandler = ResponseHandler()) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }

    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping ResultHandler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }

        print("Request URL: \(url)")

        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        request.allHTTPHeaderFields = type.headers

        if let parameters = type.body {
            do {
                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                completion(.failure(.decoding(error)))
                return
            }
        }

        networkHandler.requestDataAPI(request: request) { result in
            switch result {
            case .success(let data):
                self.responseHandler.parseResponseDecode(
                    data: data,
                    modelType: modelType,
                    completion: completion
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}

// MARK: - NetworkHandler
final class NetworkHandler {

    func requestDataAPI(
        request: URLRequest,
        completionHandler: @escaping (Result<Data, DataError>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(.network(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }

            completionHandler(.success(data))
        }.resume()
    }
}

// MARK: - ResponseHandler
final class ResponseHandler {

    func parseResponseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completion: ResultHandler<T>
    ) {
        do {
            let decodedResponse = try JSONDecoder().decode(modelType, from: data)
            completion(.success(decodedResponse))
        } catch {
            completion(.failure(.decoding(error)))
        }
    }
}
