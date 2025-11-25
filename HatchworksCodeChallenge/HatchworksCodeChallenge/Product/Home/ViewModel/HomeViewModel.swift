//
//  HomeViewModel.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import Foundation
import Observation
import RequestManager

@Observable
final class HomeViewModel {
    // MARK: - View State
    enum ViewState: Equatable {
        case loading
        case loaded(ProductListResponse)
        case error(String)
    }
    
    // MARK: - Private Properties
    private let api: HomeAPIProtocol
    private let itemsPerPage = 30
    
    // MARK: - Internal Observable properties
    @ObservationIgnored
    var products: ProductListResponse?
    private var currentPage = 1
    private var totalProducts = 0
    private var isLoadingNextPage = false
    private var hasMorePages: Bool {
        return (products?.products.count ?? 0) < totalProducts
    }
    var viewState: ViewState = .loading
    
    
    init(api: HomeAPIProtocol = HomeAPI()) {
        self.api = api
    }
    
    @MainActor
    func fetchProductList() async {
        viewState = .loading
        currentPage = 1
        products = nil
        do {
            let response = try await api.fetchProductList(page: currentPage)
            self.totalProducts = response.total
            self.products = response
            viewState = .loaded(response)
        } catch let error as NetworkError {
            switch error {
            case .noData:
                viewState = .error("We were trying to get the products but was not possible\nError: \(error)")
            case .decodeError:
                viewState = .error("Upss something went wrong decoding the data\nError: \(error)")
            case .invalidResponse, .invalidURL:
                viewState = .error("Looks like our services are down, but not worries, we are working on it and we will be back soon\nError: \(error)")
            case .invalidStatusCode(let code):
                viewState = .error("We got an error from the server with status code: \(code)\nError: \(error)")
            default:
                viewState = .error("Error: \(error)")
            }
        } catch {
            viewState = .error("Error inesperado: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchNextPage() async {
        guard !isLoadingNextPage else { return }
        guard hasMorePages else { return }
        
        isLoadingNextPage = true
        currentPage += 1
        
        do {
            let response = try await api.fetchProductList(page: currentPage)
            self.products?.products.append(contentsOf: response.products)
            self.viewState = .loaded(self.products ?? response)
        } catch {
            print("Pagination error: \(error)")
        }
        
        isLoadingNextPage = false
    }
}
