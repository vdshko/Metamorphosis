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
        $inputValue
            .combineLatest($selectedMeasurement)
            .removeDuplicates(by: ==)
            .map { [weak self] value, type in
                self?.conversionList(for: value, and: type) ?? []
            }
            .assign(to: &$selectableMeasurements)
    }
    
    func conversionList(for value: Double?, and selectedType: WeightView.WeightMeasurementType) -> [WeightView.WeightMeasurement] {
        return WeightView.WeightMeasurementType.allCases
            .compactMap { type in
                switch type {
                case selectedType: return nil
                case .mg: break // Adapter_mg(from: selectedType).value
                case .cg: break // Adapter_cg(from: selectedType).value
                case .dg: break // Adapter_dg(from: selectedType).value
                case .g: break // Adapter_g(from: selectedType).value
                case .dag: break // Adapter_dag(from: selectedType).value
                case .hg: break // Adapter_hg(from: selectedType).value
                case .kg: break // Adapter_kg(from: selectedType).value
                case .t: break // Adapter_t(from: selectedType).value
                }
                return WeightView.WeightMeasurement(value: 0.0, type: type)
            }
    }
}
