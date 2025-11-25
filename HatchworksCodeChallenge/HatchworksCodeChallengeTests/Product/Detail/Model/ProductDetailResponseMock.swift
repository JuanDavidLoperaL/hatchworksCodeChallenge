//
//  ProductDetailResponseMock.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
@testable import HatchworksCodeChallenge

extension ProductDetailResponse {
    static let mock: ProductDetailResponse = ProductDetailResponse(
        id: 1,
        title: "Test Mock",
        price: 9.56,
        discountPercentage: 1.5,
        availabilityStatus: "In Stock",
        thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp",
        shippingInformation: "Ships in 2 weeks",
        warrantyInformation: "1 year warranty",
        description: "The Eyeshadow Palette with Mirror offers a versatile range of eyeshadow shades for creating stunning eye looks. With a built-in mirror, it's convenient for on-the-go makeup application.",
        images: [
            "https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/1.webp"
        ]
    )
}
