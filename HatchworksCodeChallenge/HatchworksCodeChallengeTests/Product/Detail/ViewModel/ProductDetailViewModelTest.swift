//
//  ProductDetailViewModelTest.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import XCTest
@testable import HatchworksCodeChallenge

final class ProductDetailViewModelTests: XCTestCase {
    
    var apiMock: ProductDetailAPIMock!
    var viewModel: ProductDetailViewModel!
    
    override func setUp() {
        super.setUp()
        apiMock = ProductDetailAPIMock()
        viewModel = ProductDetailViewModel(productId: 1, api: apiMock)
    }
    
    override func tearDown() {
        apiMock = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialStateIsLoading() {
        XCTAssertEqual(viewModel.viewState, .loading)
    }
    
    func testGetProductDetailSuccess() async {
        apiMock.shouldFail = false
        
        await viewModel.getProductDetail()
        
        if case .loaded(let product) = viewModel.viewState {
            XCTAssertEqual(product.id, ProductDetailResponse.mock.id)
            XCTAssertEqual(product.title, ProductDetailResponse.mock.title)
        } else {
            XCTFail("Expected .loaded state")
        }
    }
    
    func testGetProductDetailFailsWithNoData() async {
        apiMock.shouldFail = true
        apiMock.failError = .noData
        
        await viewModel.getProductDetail()
        
        if case .error(let message) = viewModel.viewState {
            XCTAssertEqual(message, "We got some problem getting the product")
        } else {
            XCTFail("Expected .error state for .noData")
        }
    }
    
    func testGetProductDetailFailsWithDecodeError() async {
        apiMock.shouldFail = true
        apiMock.failError = .decodeError(NSError(domain: "", code: -1))
        
        await viewModel.getProductDetail()
        
        if case .error(let message) = viewModel.viewState {
            XCTAssertEqual(message, "We got some problem getting the product")
        } else {
            XCTFail("Expected .error state for .decodeError")
        }
    }
    
    func testGetProductDetailFailsWithInvalidStatusCode() async {
        apiMock.shouldFail = true
        apiMock.failError = .invalidStatusCode(500)
        
        await viewModel.getProductDetail()
        
        if case .error(let message) = viewModel.viewState {
            XCTAssertEqual(message, "We got some problem getting the product")
        } else {
            XCTFail("Expected .error state for .invalidStatusCode")
        }
    }
    
    func testGetProductDetailFailsWithInvalidURL() async {
        apiMock.shouldFail = true
        apiMock.failError = .invalidURL
        
        await viewModel.getProductDetail()
        
        if case .error(let message) = viewModel.viewState {
            XCTAssertEqual(message, "We got some problem getting the product")
        } else {
            XCTFail("Expected .error state for .invalidURL")
        }
    }
    
    func testGetProductDetailFailsWithInvalidResponse() async {
        apiMock.shouldFail = true
        apiMock.failError = .invalidResponse
        
        await viewModel.getProductDetail()
        
        if case .error(let message) = viewModel.viewState {
            XCTAssertEqual(message, "We got some problem getting the product")
        } else {
            XCTFail("Expected .error state for .invalidResponse")
        }
    }
    
    func testMultipleCallsEndsInLatestState() async {
        apiMock.shouldFail = true
        await viewModel.getProductDetail()
        
        apiMock.shouldFail = false
        await viewModel.getProductDetail()
        
        if case .loaded(let product) = viewModel.viewState {
            XCTAssertEqual(product.id, ProductDetailResponse.mock.id)
        } else {
            XCTFail("Expected .loaded state after second call")
        }
    }
    
    func testInvalidProductIdStillLoadsMock() async {
        viewModel = ProductDetailViewModel(productId: -5, api: apiMock)
        
        await viewModel.getProductDetail()
        
        if case .loaded(let product) = viewModel.viewState {
            XCTAssertEqual(product.id, ProductDetailResponse.mock.id)
        } else {
            XCTFail("Expected .loaded state")
        }
    }
}
