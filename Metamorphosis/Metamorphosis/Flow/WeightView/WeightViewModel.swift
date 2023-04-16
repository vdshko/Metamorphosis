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
        let type: String
    }
    
    final class WeightViewModel: ObservableObject {
        
        @Published var inputValue: Double?
        @Published var selectedMeasurement: String = ""
        @Published var selectableMeasurements: [WeightMeasurement] = []
        
        private let diContainer: DIContainer

        init(diContainer: DIContainer) {
            self.diContainer = diContainer
            setupDefaultValues()
            setupBinding()
        }
        
        func handleLongPress(for measurement: WeightView.WeightMeasurement) {
            UIPasteboard.general.string = String(measurement.value)
        }
    }
}

private extension WeightView.WeightViewModel {
    
    func setupDefaultValues() {
        if diContainer.storage.userStorage.measurementMultiplierToMG == nil {
            diContainer.storage.userStorage.measurementMultiplierToMG = [
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
        }
        if diContainer.storage.userStorage.measurementMultiplierFromMG == nil {
            diContainer.storage.userStorage.measurementMultiplierFromMG = [
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
        }
        selectedMeasurement = diContainer.storage.userStorage.measurementMultiplierToMG?.first?.key ?? ""
    }
    
    func setupBinding() {
        $inputValue
            .combineLatest($selectedMeasurement)
            .removeDuplicates(by: ==)
            .map { [weak self] value, type in
                self?.conversionList(for: value, and: type) ?? []
            }
            .assign(to: &$selectableMeasurements)
    }
    
    func conversionList(for value: Double?, and selectedType: String) -> [WeightView.WeightMeasurement] {
        guard let measurementMultiplierToMG: [String: Double] = diContainer.storage.userStorage.measurementMultiplierToMG,
              let measurementMultiplierFromMG: [String: Double] = diContainer.storage.userStorage.measurementMultiplierFromMG else { return [] }
        return measurementMultiplierToMG
            .compactMap { type in
                guard type.key != selectedType else { return nil }
                guard let value: Double = value else { return WeightView.WeightMeasurement(value: 0.0, type: type.key) }
                let multiplierToMG: Double = measurementMultiplierToMG[selectedType, default: 0.0]
                let multiplierFromMG: Double = measurementMultiplierFromMG[type.key, default: 0.0]
                let result: Double = value * multiplierToMG * multiplierFromMG
                return WeightView.WeightMeasurement(value: result, type: type.key)
            }
    }
}
