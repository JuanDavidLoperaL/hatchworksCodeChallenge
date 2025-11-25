//
//  ProductsCoordinatorView.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import Foundation
import SwiftUI

struct ProductsCoordinatorView: View {
    
    @State var coordinatorLogic: ProductsCoordinatorLogic = ProductsCoordinatorLogic()
    
    var body: some View {
        NavigationStack(path: $coordinatorLogic.path) {
            HomeView()
                .navigationDestination(for: ProductScreens.self) { screen in
                    switch screen {
                    case .productList:
                        HomeView()
                    case .productDetail(let id):
                        EmptyView()
                    }
                }
        }
        .environment(coordinatorLogic)
    }
}
