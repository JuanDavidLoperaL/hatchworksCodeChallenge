//
//  ViewExtension.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import SwiftUI

extension View {
    func errorTextStyle() -> some View {
        self.modifier(ErrorTextModifier())
    }
    
    func infoTextStyle(foregroundColor: Color) -> some View {
        self.modifier(InfoTextModifier(foregroundColor: foregroundColor))
    }
}
