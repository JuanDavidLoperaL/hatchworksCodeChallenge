//
//  ProductDetailViewModel.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
import Observation

@Observable
final class ProductDetailViewModel {
    
    // MARK: - View State
    enum ViewState: Equatable {
        case loading
        case loaded(ProductDetailResponse)
        case error(String)
    }
    
    // MARK: - Private Properties
    private let productId: Int
    private let api: ProductDetailAPIProtocol
    
    // MARK: - Internal Properties
    var viewState: ViewState = .loading
    
    // MARK: - Internal Init
    init(productId: Int, api: ProductDetailAPIProtocol = ProductDetailAPI()) {
        self.productId = productId
        self.api = api
    }
    
    @MainActor
    func getProductDetail() async {
        viewState = .loading
        do {
            let response = try await api.getProductDetail(with: productId)
            viewState = .loaded(response)
        } catch {
            viewState = .error("We got some problem getting the product")
        }
    }
}
