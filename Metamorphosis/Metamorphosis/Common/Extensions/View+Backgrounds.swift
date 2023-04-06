//
//  View+Backgrounds.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 05.04.2023.
//

import SwiftUI

enum BackgroundType {
    
    case main
    case secondary
}

extension View {
    
    @ViewBuilder
    func background(_ type: BackgroundType) -> some View {
        switch type {
        case .main: self.background(Asset.Colors.Background.main.color)
        case .secondary: self.background(Asset.Colors.Background.secondary.color)
        }
    }
}
