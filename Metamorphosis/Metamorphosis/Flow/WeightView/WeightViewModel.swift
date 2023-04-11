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
        
        case mg, cg, dg, g
        case dag, kg, q, t
        case oz = "Oz", pound
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
                guard type != selectedType else { return nil }
                return convert(from: value, and: selectedType, to: type)
            }
    }
    
    func convert(from value: Double?, and fromType: WeightView.WeightMeasurementType, to toType: WeightView.WeightMeasurementType) -> WeightView.WeightMeasurement {
        guard let value: Double = value else { return WeightView.WeightMeasurement(value: 0.0, type: toType) }
        
        let preResult: Double
        switch fromType {
        case .mg: preResult = value
        case .cg: preResult = value * 10.0
        case .dg: preResult = value * 100.0
        case .g: preResult = value * 1_000.0
        case .dag: preResult = value * 10_000.0
        case .kg: preResult = value * 1_000_000.0
        case .q: preResult = value * 100_000_000.0
        case .t: preResult = value * 1_000_000_000.0
        case .oz: preResult = value * 31_103.4768
        case .pound: preResult = value * 453_592.0
        }
        
        let result: Double
        switch toType {
        case .mg: result = preResult
        case .cg: result = preResult * 0.1
        case .dg: result = preResult * 0.01
        case .g: result = preResult * 0.001
        case .dag: result = preResult * 0.000_1
        case .kg: result = preResult * 0.000_001
        case .q: result = preResult * 0.000_000_01
        case .t: result = preResult * 0.000_000_001
        case .oz: result = preResult * 0.000_035_274
        case .pound: result = preResult * 0.000_002_204_6
        }
        
        return WeightView.WeightMeasurement(value: result, type: toType)
    }
}
