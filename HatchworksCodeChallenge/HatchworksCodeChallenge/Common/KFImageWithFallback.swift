//
//  KFImageWithFallback.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 24/11/25.
//

import SwiftUI
import Kingfisher

struct KFImageWithFallback: View {
    let url: String

    @State private var loadFailed = false

    var body: some View {
        ZStack {
            if loadFailed {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: 80, height: 80)
            } else {
                KFImage(URL(string: url))
                    .onFailure { _ in
                        loadFailed = true
                    }
                    .placeholder {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                    .clipped()
            }
        }
    }
}
