//
//  HomeAPIMock.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
import RequestManager
@testable import HatchworksCodeChallenge

final class HomeAPIMock: HomeAPIProtocol {
    
    var shouldFail: Bool = false
    var failError: NetworkError = .noData
    
    func fetchProductList(page: Int) async throws -> ProductListResponse {
        
        if shouldFail {
            // Here not apply @unknown default since this enum is created by the app(me), so all cases are known
            switch failError {
            case .noData:
                throw NetworkError.noData
            case .decodeError(let err):
                throw NetworkError.decodeError(err)
            case .invalidStatusCode(let code):
                throw NetworkError.invalidStatusCode(code)
            case .invalidURL:
                throw NetworkError.invalidURL
            case .invalidResponse:
                throw NetworkError.invalidResponse
            }
        }
        
        return ProductListResponse.mock
    }
}
