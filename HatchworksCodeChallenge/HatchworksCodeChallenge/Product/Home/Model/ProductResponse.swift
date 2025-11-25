//
//  ProductResponse.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import Foundation

struct ProductResponse: Decodable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let discountPercentage: Double
    let availabilityStatus: String
    let thumbnail: String
}
