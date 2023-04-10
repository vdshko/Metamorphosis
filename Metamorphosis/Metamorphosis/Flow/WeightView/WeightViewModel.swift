//
//  WeightViewModel.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 07.04.2023.
//

import SwiftUI

extension WeightView {
    
    enum WeightMeasurements: String, CaseIterable {
        
        case mg, cg, dg
        case g, dag, hg
        case kg, t
    }
    
    final class WeightViewModel: ObservableObject {
        
        @Published var inputValue: Double?
        @Published var selectedMeasurement: WeightMeasurements = .kg
        @Published var selectableMeasurements: [WeightMeasurements] = WeightMeasurements.allCases
        
        init() {
            setupBinding()
        }
    }
}

private extension WeightView.WeightViewModel {
    
    func setupBinding() {
        $selectedMeasurement
            .map { measurement in
                return WeightView.WeightMeasurements.allCases.filter { $0 != measurement }
            }
            .assign(to: &$selectableMeasurements)
    }
}
