//
//  NetworkError.swift
//  RequestManager
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import Foundation

public enum NetworkError: Error {
    case noData
    case decodeError(Error)
    case invalidStatusCode(Int)
    case invalidURL
    case invalidResponse
}
