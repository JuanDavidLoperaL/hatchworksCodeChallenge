//
//  ProductDetailAPI.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
import RequestManager

protocol ProductDetailAPIProtocol {
    func getProductDetail(with id: Int) async throws -> ProductDetailResponse
}

final class ProductDetailAPI: ProductDetailAPIProtocol {
    
    // MARK: - Private Properties
    private let baseURLStr: String
    
    init(baseURLStr: String = "https://dummyjson.com/products") {
        self.baseURLStr = baseURLStr
    }
    
    func getProductDetail(with id: Int) async throws -> ProductDetailResponse {
        guard var baseURL = URL(string: baseURLStr) else {
            throw NetworkError.invalidURL
        }
        let url = baseURL.appending(path: "/\(id)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethods.get.rawValue
        let object: ProductDetailResponse = try await APIManager.shared.makeRequest(urlRequest: urlRequest)
        return object
    }
}

