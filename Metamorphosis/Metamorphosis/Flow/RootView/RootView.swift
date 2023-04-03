//
//  RootView.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 02.04.2023.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel: RootViewModel = RootViewModel()
    
    private let gridColumns: [GridItem] = [
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            content
                .navigationDestination(for: String.self) { value in
                    Text("String = \(value)")
                }
        }
    }
    
    var content: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns) {
                ForEach(viewModel.units, id: \.self) { [weak viewModel] unit in
                    Text(unit.rawValue)
                        .onTapGesture {
                            viewModel?.navigationPath.append(unit.rawValue)
                        }
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        RootView()
    }
}
