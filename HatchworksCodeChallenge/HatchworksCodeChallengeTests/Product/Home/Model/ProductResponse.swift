//
//  ProductResponse.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
@testable import HatchworksCodeChallenge

extension ProductResponse {
    static var mock: ProductResponse = ProductResponse(
        id: 1,
        title: "Test Mock",
        price: 5.0,
        discountPercentage: 0.0,
        availabilityStatus: "In Stock",
        thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp"
    )
}

