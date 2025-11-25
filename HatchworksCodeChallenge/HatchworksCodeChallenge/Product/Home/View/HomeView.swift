//
//  HomeView.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import SwiftUI

struct HomeView: View {
    
    /*
     With the new Observation system introduced by Apple in iOS 17,
     view models annotated with `@Observable` should be stored in the
     view using `@State` instead of `@StateObject` or `@ObservedObject`.
     
     `@Observable` types do not conform to `ObservableObject`, and they
     don’t rely on Combine or @Published. Instead, they use Swift’s new
     accessor-based change tracking, which is fully compatible with `@State`.
     
     Therefore:
     - Use `@Observable` for the ViewModel
     - Store it in the View using `@State`
     - Reserve `@StateObject` and `@ObservedObject` only for legacy
     `ObservableObject`-based models.
     
     This ensures correct lifecycle handling and takes full advantage of
     the modern Observation system.
     */
    @State var viewModel = HomeViewModel()
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case.error(let error):
                Text("Error: \(error)")
                    .foregroundColor(.red)
            case .loading:
                Text("Loading...")
            case .loaded(let products):
                ProductListView(products: products.products) {
                    Task {
                        await viewModel.fetchNextPage()
                    }
                }
            }
        }
        .navigationTitle("Juan Store")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.fetchProductList()
        }
    }
}


#Preview {
    HomeView()
}
