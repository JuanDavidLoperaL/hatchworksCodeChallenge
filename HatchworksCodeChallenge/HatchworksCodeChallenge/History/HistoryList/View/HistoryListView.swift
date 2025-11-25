//
//  HistoryListView.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import SwiftUI

struct HistoryListView: View {
    
    @State var viewModel: HistoryListViewModel
    
    init() {
        _viewModel = State(initialValue: HistoryListViewModel())
    }
    
    var body: some View {
        VStack {
            List(viewModel.purchaseHistory, id: \.self) { item in
                HStack(alignment: .top, spacing: 12) {
                    KFImageWithFallback(url: item.thumbnail ?? "")
                        .padding(.top, 25)
                    VStack(alignment: .leading) {
                        Text(item.title ?? "Unknown")
                            .font(.headline)
                        Text("Price: \(item.price, specifier: "%.2f")")
                            .infoTextStyle(foregroundColor: .black)
                            .padding(.bottom, 5)
                        Text("Puchase Date: \(item.date?.formatted() ?? "")")
                            .infoTextStyle(foregroundColor: .gray)
                            .padding(.bottom, 5)
                        Text("shipping Information: \(item.shippingInformation ?? "")")
                            .infoTextStyle(foregroundColor: .gray)
                    }
                }
                .padding(.vertical, 6)
            }
            .navigationBarTitle("History")
        }
        .onAppear {
            viewModel.refresh()
        }
        
    }
}

#Preview {
    HistoryListView()
}
