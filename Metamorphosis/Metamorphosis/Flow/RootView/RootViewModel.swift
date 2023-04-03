//
//  RootViewModel.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 02.04.2023.
//

import SwiftUI

extension RootView {
    
    final class RootViewModel: ObservableObject {
        
        @Published var navigationPath: NavigationPath = NavigationPath()
        
        var units: [NavigationType] = [
            NavigationType.speed,
            NavigationType.temperature,
            NavigationType.weight
        ]
        
        init() {
            setupBinding()
        }
    }
}

private extension RootView.RootViewModel {
    
    func setupBinding() {
        AppState.shared.$navigationPath
            .assign(to: &$navigationPath)
    }
}
