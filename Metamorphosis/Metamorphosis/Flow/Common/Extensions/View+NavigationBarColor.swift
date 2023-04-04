//
//  View+NavigationBarColor.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 05.04.2023.
//

import SwiftUI

extension View {
    
    func navigationBarTitleTextColor(_ color: ColorAsset) -> some View {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: color.uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: color.uiColor]
        
        return self
    }
}
