//
//  ProductDetailViewModel.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import CoreData
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
    private var product: ProductDetailResponse?
    
    // MARK: - Internal Properties
    var viewState: ViewState = .loading
    var loadingPurchase: Bool = false
    
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
            self.product = response
            viewState = .loaded(response)
        } catch {
            viewState = .error("We got some problem getting the product")
        }
    }

    func addProductToHistory() async -> Bool {
        guard let product = product else { return false }
        let bgContext = CoreDataManager.shared.newBackgroundContext()
        
        return await withCheckedContinuation { continuation in
            bgContext.perform {
                let purchase = Purchases(context: bgContext)
                purchase.id = Int64(product.id)
                purchase.title = product.title
                purchase.price = product.price
                purchase.thumbnail = product.thumbnail
                purchase.shippingInformation = product.shippingInformation
                purchase.date = Date()

                do {
                    try CoreDataManager.shared.saveContext(selectedContext: bgContext)
                    continuation.resume(returning: true)
                } catch {
                    continuation.resume(returning: false)
                }
            }
        }
    }

}
