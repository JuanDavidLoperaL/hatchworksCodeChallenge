//
//  InfoTextModifier.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import SwiftUI

struct InfoTextModifier: ViewModifier {
    
    var foregroundColor: Color = .black
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(foregroundColor)
    }
}
