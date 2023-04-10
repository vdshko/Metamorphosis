//
//  WeightViewModel.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 07.04.2023.
//

import SwiftUI

extension WeightView {
    
    struct WeightMeasurement: Hashable {
        
        let value: Double
        let type: WeightMeasurementType
    }
    
    enum WeightMeasurementType: String, CaseIterable {
        
        case mg, cg, dg
        case g, dag, hg
        case kg, t
    }
    
    final class WeightViewModel: ObservableObject {
        
        @Published var inputValue: Double?
        @Published var selectedMeasurement: WeightMeasurementType = .kg
        @Published var selectableMeasurements: [WeightMeasurement] = []
        
        init() {
            setupBinding()
        }
        
        func handleLongPress(for measurement: WeightView.WeightMeasurement) {
            UIPasteboard.general.string = String(measurement.value)
        }
    }
}

private extension WeightView.WeightViewModel {
    
    func setupBinding() {
        $selectedMeasurement
            .map { selected in
                return WeightView.WeightMeasurementType.allCases
                    .filter { $0 != selected }
                    .map { return WeightView.WeightMeasurement(value: 0.0, type: $0) }
            }
            .assign(to: &$selectableMeasurements)
    }
}
