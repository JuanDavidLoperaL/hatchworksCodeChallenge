//
//  ProductDetailView.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import SwiftUI

struct ProductDetailView: View {
    
    // MARK: - State
    @State private var showConfirmPurchase = false
    @State var viewModel: ProductDetailViewModel
    
    // MARK: - Init
    init(productId: Int) {
        _viewModel = State(initialValue: ProductDetailViewModel(productId: productId))
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView("Loading product...")
            case .error(let error):
                Text("Error:\n\(error)")
                    .errorTextStyle()
            case .loaded(let product):
                productDetailContent(product)
            }
        }
        .task { await viewModel.getProductDetail() }
        .alert("Confirm purchase", isPresented: $showConfirmPurchase) {
            Button("Confirm", role: .destructive) {
                print("Purchase confirmed")
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("¿Do you want to buy this product?")
        }
    }
}

// MARK: - Subviews
private extension ProductDetailView {
    
    // MARK: - Full Content
    @ViewBuilder
    func productDetailContent(_ product: ProductDetailResponse) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                productImage(product.thumbnail)
                titleAndPriceSection(product)
                descriptionSection(product.description)
                additionalInfoSection(product)
                buyButton
                
            }
        }
    }
    
    // MARK: - Main Image
    func productImage(_ url: String) -> some View {
        KFImageWithFallback(url: url)
    }
    
    // MARK: - Title + Price
    func titleAndPriceSection(_ product: ProductDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(product.title)
                .font(.title)
                .fontWeight(.semibold)
            
            HStack {
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue.opacity(0.8))
                
                Text("-\(product.discountPercentage, specifier: "%.1f")%")
                    .infoTextStyle(foregroundColor: .green)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Description
    func descriptionSection(_ description: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.headline)
            
            Text(description)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Additional Info
    func additionalInfoSection(_ product: ProductDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Shipping information: \(product.shippingInformation)")
            Text("Warranty: \(product.warrantyInformation)")
            Text("Status: \(product.availabilityStatus)")
        }
        .font(.subheadline)
        .foregroundColor(.gray)
        .padding(.horizontal)
    }
    
    // MARK: - Buy Button
    var buyButton: some View {
        Button {
            showConfirmPurchase = true
        } label: {
            Text("Buy")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.8))
                .cornerRadius(12)
        }
        .padding()
    }
}


#Preview {
    ProductDetailView(productId: 1)
}

