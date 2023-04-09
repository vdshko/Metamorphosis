//
//  WeightViewModel.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 07.04.2023.
//

import SwiftUI

extension WeightView {
    
    final class WeightViewModel: ObservableObject {
        
        @Published var inputValue: Double?
        @Published var selectedMeasurement: Int = 1
        
        init() {
            setupBinding()
        }
    }
}

private extension WeightView.WeightViewModel {
    
    func setupBinding() {}
}
