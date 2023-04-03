//
//  AppState.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 03.04.2023.
//

import SwiftUI

final class AppState: ObservableObject {
    
    @Published var navigationPath: NavigationPath = NavigationPath()
    
    var shared: AppState = AppState()
    
    private init() {}
}
