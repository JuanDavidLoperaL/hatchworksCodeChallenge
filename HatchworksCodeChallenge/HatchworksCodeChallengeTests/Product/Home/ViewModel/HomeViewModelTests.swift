//
//  HomeViewModelTests.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import XCTest
import RequestManager
@testable import HatchworksCodeChallenge

final class HomeViewModelTests: XCTestCase {
    
    var mockAPI: HomeAPIMock!
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        mockAPI = HomeAPIMock()
        viewModel = HomeViewModel(api: mockAPI)
    }
    
    override func tearDown() {
        mockAPI = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Initial State
    func testInitialStateIsLoading() {
        XCTAssertEqual(viewModel.viewState, .loading)
        XCTAssertNil(viewModel.products)
    }
    
    // MARK: - Success Case
    func testFetchProductListSuccessUpdatesStateToLoaded() async {
        mockAPI.shouldFail = false
        
        await viewModel.fetchProductList()
        
        switch viewModel.viewState {
        case .loaded(let response):
            XCTAssertNotNil(response)
            XCTAssertEqual(viewModel.products, response)
        default:
            XCTFail("Expected state to be .loaded")
        }
        
    }
    
    // MARK: - Error Cases
    func testFetchProductListNoDataErrorSetsErrorState() async {
        mockAPI.shouldFail = true
        mockAPI.failError = .noData
        
        await viewModel.fetchProductList()
        
        switch viewModel.viewState {
        case .error(let message):
            XCTAssertTrue(message.contains("not possible"))
        default:
            XCTFail("Expected .error state")
        }
    }
    
    func testFetchProductListDecodeErrorSetsDecodeMessage() async {
        mockAPI.shouldFail = true
        mockAPI.failError = .decodeError(NSError(domain: "decode", code: 0))
        
        await viewModel.fetchProductList()
        
        switch viewModel.viewState {
        case .error(let message):
            XCTAssertTrue(message.contains("decoding"))
        default:
            XCTFail("Expected .error state")
        }
    }
    
    func testFetchProductListInvalidStatusCodeSetsCorrectMessage() async {
        mockAPI.shouldFail = true
        mockAPI.failError = .invalidStatusCode(500)
        
        await viewModel.fetchProductList()
        
        switch viewModel.viewState {
        case .error(let message):
            XCTAssertTrue(message.contains("500"))
        default:
            XCTFail("Expected .error state")
        }
    }
    
    func testFetchProductListInvalidURLSetsServiceDownMessage() async {
        mockAPI.shouldFail = true
        mockAPI.failError = .invalidURL
        
        await viewModel.fetchProductList()
        
        switch viewModel.viewState {
        case .error(let message):
            XCTAssertTrue(message.contains("services are down"))
        default:
            XCTFail("Expected .error state")
        }
    }
    
    func testFetchProductListInvalidResponseSetsServiceDownMessage() async {
        mockAPI.shouldFail = true
        mockAPI.failError = .invalidResponse
        
        await viewModel.fetchProductList()
        
        switch viewModel.viewState {
        case .error(let message):
            XCTAssertTrue(message.contains("services are down"))
        default:
            XCTFail("Expected .error state")
        }
    }
    
    func testFetchNextPageAppendsProducts() async {
        mockAPI.shouldFail = false

        await viewModel.fetchProductList()
        
        let initialCount = viewModel.products?.products.count ?? 0

        await viewModel.fetchNextPage()
        
        let finalCount = viewModel.products?.products.count ?? 0
        
        XCTAssertEqual(finalCount, initialCount * 2)
    }
    
    func testFetchNextPageDoesNothingIfProductsNil() async {
        mockAPI.shouldFail = false
        
        await viewModel.fetchNextPage()
        
        XCTAssertNil(viewModel.products, "Products should remain nil if next page is called before initial load")
    }
    
    // MARK: - Corner Case: Unexpected Error
    func testFetchProductListUnexpectedErrorSetsGenericErrorMessage() async {
        mockAPI.shouldFail = true
        mockAPI.failError = NetworkError.decodeError(NSError(domain: "unknown", code: -1))
        
        await viewModel.fetchProductList()
        
        switch viewModel.viewState {
        case .error(let message):
            XCTAssertTrue(message.contains("Error"))
        default:
            XCTFail("Expected .error state")
        }
    }
    
    // MARK: - Corner Case: Reset values
    func testErrorMessageClearedOnSuccess() async {
        mockAPI.shouldFail = true
        mockAPI.failError = .noData
        
        await viewModel.fetchProductList()
        
        mockAPI.shouldFail = false
        
        await viewModel.fetchProductList()
        
        XCTAssertNotNil(viewModel.products)
    }
}

