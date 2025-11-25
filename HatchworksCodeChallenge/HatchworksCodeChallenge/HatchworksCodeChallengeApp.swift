//
//  HatchworksCodeChallengeApp.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import SwiftUI

@main
struct HatchworksCodeChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ProductsCoordinatorView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                HistoryCoordinatorView()
                    .tabItem {
                        Label("Purchase History", systemImage: "clock.arrow.circlepath")
                    }
            }
        }
    }
}
