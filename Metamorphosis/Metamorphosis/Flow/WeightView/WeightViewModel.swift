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
    
    struct WeightMeasurement2: Hashable {
        
        let value: Double
        let type: String
    }
    
    enum WeightMeasurementType: String, CaseIterable {
        
        case mg, cg, dg, g
        case dag, kg, q, t
        case oz = "Oz", pound
    }
    
    final class WeightViewModel: ObservableObject {
        
        @Published var inputValue: Double?
        @Published var selectedMeasurement: WeightMeasurementType = .kg
        @Published var selectedMeasurement2: String = "kg"
        @Published var selectableMeasurements: [WeightMeasurement] = []
        @Published var selectableMeasurements2: [WeightMeasurement2] = []
        
        private var measurementMultiplierToMG: [String: Double] = [
            "mg": 1.0,
            "cg": 10.0,
            "dg": 100.0,
            "g": 1_000.0,
            "dag": 10_000.0,
            "kg": 1_000_000.0,
            "q": 100_000_000.0,
            "t": 1_000_000_000.0,
            "Oz": 31_103.4768,
            "pound": 453_592.0
        ]
        
        private var measurementMultiplierFromMG: [String: Double] = [
            "mg": 1.0,
            "cg": 0.1,
            "dg": 0.01,
            "g": 0.001,
            "dag": 0.000_1,
            "kg": 0.000_001,
            "q": 0.000_000_01,
            "t": 0.000_000_001,
            "Oz": 0.000_035_274,
            "pound": 0.000_002_204_6
        ]
        
        init() {
            setupBinding()
        }
        
        func handleLongPress(for measurement: WeightView.WeightMeasurement) {
            UIPasteboard.general.string = String(measurement.value)
        }
        
        func handleLongPress2(for measurement: WeightView.WeightMeasurement2) {
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
        $inputValue
            .combineLatest($selectedMeasurement2)
            .removeDuplicates(by: ==)
            .map { [weak self] value, type in
                self?.conversionList2(for: value, and: type) ?? []
            }
            .assign(to: &$selectableMeasurements2)
    }
    
    func conversionList(for value: Double?, and selectedType: WeightView.WeightMeasurementType) -> [WeightView.WeightMeasurement] {
        return WeightView.WeightMeasurementType.allCases
            .compactMap { type in
                guard type != selectedType else { return nil }
                return convert(from: value, and: selectedType, to: type)
            }
    }
    
    func conversionList2(for value: Double?, and selectedType: String) -> [WeightView.WeightMeasurement2] {
        return measurementMultiplierToMG
            .compactMap { type in
                guard type.key != selectedType else { return nil }
                return convert2(from: value, and: selectedType, to: type.key)
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
    
    func convert2(from value: Double?, and fromType: String, to toType: String) -> WeightView.WeightMeasurement2 {
        guard let value: Double = value else { return WeightView.WeightMeasurement2(value: 0.0, type: toType) }
        let multiplierToMG: Double = measurementMultiplierToMG[fromType, default: 0.0]
        let multiplierFromMG: Double = measurementMultiplierFromMG[toType, default: 0.0]
        let result: Double = value * multiplierToMG * multiplierFromMG
        return WeightView.WeightMeasurement2(value: result, type: toType)
    }
}
