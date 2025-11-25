//
//  HistoryListViewModelTest.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import XCTest
@testable import HatchworksCodeChallenge

final class HistoryListViewModelTests: XCTestCase {
    
    private var mockCoreDataManager: MockCoreDataManager!
    private var viewModel: HistoryListViewModel!
    
    override func setUp() {
        super.setUp()
        mockCoreDataManager = MockCoreDataManager()
        viewModel = HistoryListViewModel(coreData: mockCoreDataManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoreDataManager = nil
        super.tearDown()
    }
    
    func testRefreshLoadsPurchases() {
        let purchase = Purchases(context: mockCoreDataManager.context)
        purchase.title = "Test Product"
        purchase.id = 1
        
        mockCoreDataManager.mockPurchases = [purchase]
        
        viewModel.refresh()
        
        XCTAssertEqual(viewModel.purchaseHistory.count, 1)
        XCTAssertEqual(viewModel.purchaseHistory.first?.title, "Test Product")
    }
    
    func testRefreshWithEmptyList() {
        mockCoreDataManager.mockPurchases = []
        
        viewModel.refresh()
        
        XCTAssertTrue(viewModel.purchaseHistory.isEmpty)
    }
    
    func testRefreshReplacesOldData() {
        let oldPurchase = Purchases(context: mockCoreDataManager.context)
        oldPurchase.title = "Old"
        
        let newPurchase = Purchases(context: mockCoreDataManager.context)
        newPurchase.title = "New"
        
        mockCoreDataManager.mockPurchases = [oldPurchase]
        viewModel.refresh()
        XCTAssertEqual(viewModel.purchaseHistory.first?.title, "Old")
        
        mockCoreDataManager.mockPurchases = [newPurchase]
        viewModel.refresh()
        
        XCTAssertEqual(viewModel.purchaseHistory.first?.title, "New")
    }
}
