//
//  ButtonStyles.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 09.04.2023.
//

import SwiftUI

struct HiddenButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 0.0)
            .hidden()
    }
}
