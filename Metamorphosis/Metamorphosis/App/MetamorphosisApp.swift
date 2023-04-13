//
//  MetamorphosisApp.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 31.03.2023.
//

import SwiftUI
import DebugFrame

@main
struct MetamorphosisApp: App {
    
    private let diContainer: DIContainer
    
    private var rootViewModel: RootView.RootViewModel {
        return RootView.RootViewModel(diContainer: diContainer)
    }
    
    init() {
        let appState: AppState = AppState()
        let storage: Storage = Storage.shared
        diContainer = DIContainer(appState: appState, storage: storage)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: rootViewModel)
        }
    }
}
