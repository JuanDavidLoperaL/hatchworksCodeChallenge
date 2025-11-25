//
//  ProductDetailResponse.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation

struct ProductDetailResponse: Decodable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let discountPercentage: Double
    let availabilityStatus: String
    let thumbnail: String
    let shippingInformation: String
    let warrantyInformation: String
    let description: String
    let images: [String]
}
