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
    
    func refresh() {
        let context = CoreDataManager.shared.context
        purchaseHistory = CoreDataManager.shared.fetchPurchases(context: context)
    }
}
