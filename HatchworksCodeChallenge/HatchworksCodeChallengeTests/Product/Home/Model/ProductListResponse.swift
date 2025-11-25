//
//  ProductListResponse.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
@testable import HatchworksCodeChallenge

extension ProductListResponse {
    static let mock: ProductListResponse = ProductListResponse(products: [ProductResponse.mock], total: 100)
}
