//
//  ProductListView.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import Kingfisher
import SwiftUI

struct ProductListView: View {
    @Environment(ProductsCoordinatorLogic.self) var coordinator
    
    let products: [ProductResponse]
    var loadNextPage: () -> Void
    
    var body: some View {
        List(products, id: \.id) { product in
            HStack(alignment: .top, spacing: 12) {
                KFImageWithFallback(url: product.thumbnail)
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.title)
                        .font(.headline)
                    Text("Price: $\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                    if product.discountPercentage > 0 {
                        Text("Disccount: \(product.discountPercentage, specifier: "%.1f")%")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                    Text("availability: \(product.availabilityStatus)")
                        .font(.subheadline)
                        .foregroundColor(
                            availabilityColor(availabilityStatus: product.availabilityStatus)
                        )
                }
            }
            .padding(.vertical, 6)
//            .onTapGesture {
//                coordinator.path.append(ProductsScreen.productDetail(product.id))
//            }
            .onAppear {
                if product.id == products.last?.id {
                    loadNextPage()
                }
            }
        }
    }
    
    private func availabilityColor(availabilityStatus: String) -> Color {
        availabilityStatus.lowercased() == "in stock" ? .green : .red
    }
}

#Preview {
    ProductListView(products: [ProductResponse(id: 0, title: "Test title", price: 1.0, discountPercentage: 0.0, availabilityStatus: "Available", thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp")], loadNextPage: {})
}

