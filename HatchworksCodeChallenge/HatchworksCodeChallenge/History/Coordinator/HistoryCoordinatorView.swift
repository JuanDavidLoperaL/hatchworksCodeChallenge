//
//  HistoryCoordinatorView.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import Foundation
import SwiftUI

struct HistoryCoordinatorView: View {
    
    @State var coordinatorLogic: HistoryCoordinatorLogic = HistoryCoordinatorLogic()
    
    var body: some View {
        NavigationStack(path: $coordinatorLogic.path) {
            HistoryListView()
                .navigationDestination(for: HistoryScreens.self) { screen in
                    switch screen {
                    case .history:
                        HistoryListView()
                    }
                }
        }
        .environment(coordinatorLogic)
    }
}
