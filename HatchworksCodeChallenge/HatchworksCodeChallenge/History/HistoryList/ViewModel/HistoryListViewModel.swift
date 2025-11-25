//
//  HistoryListViewModel.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
import Observation

@Observable
final class HistoryListViewModel {
    
    private(set) var purchaseHistory: [Purchases] = []
    private let coreData: CoreDataManagerProtocol
    
    init(coreData: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreData = coreData
    }
    
    func refresh() {
        let context = coreData.context
        purchaseHistory = coreData.fetchPurchases(context: context)
    }
}
