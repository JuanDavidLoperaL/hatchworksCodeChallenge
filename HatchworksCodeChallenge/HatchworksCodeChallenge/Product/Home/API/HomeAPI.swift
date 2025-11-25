//
//  HomeAPI.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import Foundation
import RequestManager


protocol HomeAPIProtocol {
    func fetchProductList(page: Int) async throws -> ProductListResponse
}

final class HomeAPI: HomeAPIProtocol {
    
    // MARK: - Private Properties
    private let baseURLStr: String
    private let itemsLimit: Int = 30
    
    // MARK: - Internal Init
    init(baseURLStr: String = "https://dummyjson.com/products") {
        self.baseURLStr = baseURLStr
    }
    
    func fetchProductList(page: Int) async throws -> ProductListResponse {
        guard var urlComponents = URLComponents(string: baseURLStr) else {
            throw NetworkError.invalidURL
        }
        let skip = (page - 1) * itemsLimit
        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "\(itemsLimit)"),
            URLQueryItem(name: "skip", value: "\(skip)")
        ]
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethods.get.rawValue
        let object: ProductListResponse = try await APIManager.shared.makeRequest(urlRequest: urlRequest)
        return object
    }
}
