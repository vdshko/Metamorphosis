//
//  DIContainer+Preview.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 14.04.2023.
//

import Foundation

extension DIContainer {
    
    static var preview: DIContainer {
        return preview()
    }
    
    static func preview(
        appState: AppState = AppState(),
        storage: Storage = Storage.preview
    ) -> DIContainer {
        return DIContainer(
            appState: appState,
            storage: storage
        )
    }
}
