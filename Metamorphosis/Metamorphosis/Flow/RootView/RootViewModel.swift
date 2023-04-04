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
        @Published private(set) var units: [Unit] = []
        
        init() {
            setupBinding()
            setupUnits()
        }
        
        func handleCellTap(for unit: Unit) {
            AppState.shared.navigationPath.append(unit.navigationType)
        }
    }
}

private extension RootView.RootViewModel {
    
    func setupBinding() {
        $navigationPath
            .assign(to: &AppState.shared.$navigationPath)
        AppState.shared.$navigationPath
            .removeDuplicates()
            .assign(to: &$navigationPath)
    }
    
    func setupUnits() {
        units.append(contentsOf: [
            Unit(title: L10n.Units.area, thumbnail: Asset.Assets.Units.area, color: Asset.Colors.Units.area, navigationType: .area),
            Unit(title: L10n.Units.currency, thumbnail: Asset.Assets.Units.currency, color: Asset.Colors.Units.currency, navigationType: .currency),
            Unit(title: L10n.Units.data, thumbnail: Asset.Assets.Units.data, color: Asset.Colors.Units.data, navigationType: .data),
            Unit(title: L10n.Units.angles, thumbnail: Asset.Assets.Units.angles, color: Asset.Colors.Units.angles, navigationType: .angles),
            Unit(title: L10n.Units.length, thumbnail: Asset.Assets.Units.length, color: Asset.Colors.Units.length, navigationType: .length),
            Unit(title: L10n.Units.power, thumbnail: Asset.Assets.Units.power, color: Asset.Colors.Units.power, navigationType: .power),
            Unit(title: L10n.Units.pressure, thumbnail: Asset.Assets.Units.pressure, color: Asset.Colors.Units.pressure, navigationType: .pressure),
            Unit(title: L10n.Units.speed, thumbnail: Asset.Assets.Units.speed, color: Asset.Colors.Units.speed, navigationType: .speed),
            Unit(title: L10n.Units.temperature, thumbnail: Asset.Assets.Units.temperature, color: Asset.Colors.Units.temperature, navigationType: .temperature),
            Unit(title: L10n.Units.time, thumbnail: Asset.Assets.Units.time, color: Asset.Colors.Units.time, navigationType: .time),
            Unit(title: L10n.Units.volume, thumbnail: Asset.Assets.Units.volume, color: Asset.Colors.Units.volume, navigationType: .volume),
            Unit(title: L10n.Units.weight, thumbnail: Asset.Assets.Units.weight, color: Asset.Colors.Units.weight, navigationType: .weight)
        ])
    }
}
