//
//  ErrorTextModifier.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import SwiftUI

struct ErrorTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}
