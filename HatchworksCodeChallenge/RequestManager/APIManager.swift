//
//  APIManager.swift
//  RequestManager
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import Foundation

final public class APIManager {
    
    public static let shared = APIManager()
    
    private init() {}
    
    public func makeRequest<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        // Checking this store free API, looks like always we are going to get productos in body response, so that's why this validation
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            throw NetworkError.decodeError(error)
        }
    }
}

