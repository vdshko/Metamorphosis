//
//  DIContainer.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 14.04.2023.
//

import Foundation

final class DIContainer {
    
    let appState: AppState
    let storage: Storage
    
    init(appState: AppState, storage: Storage) {
        self.appState = appState
        self.storage = storage
    }
}
