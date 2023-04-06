//
//  RootView.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 02.04.2023.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel: RootViewModel = RootViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            content
                .navigationTitle(L10n.Root.Navigation.title)
                .navigationBarTitleDisplayMode(.large)
                .navigationDestination(for: NavigationType.self) { type in
                    switch type {
                    case .weight: WeightView()
                    default: Text(L10n.Common.comingSoon)
                    }
                }
        }
        .accentColor(Asset.Colors.Base.white)
        .navigationBarTitleTextColor(Asset.Colors.Base.white)
    }
    
    private var content: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(viewModel.units, id: \.self) { unit in
                    cell(for: unit)
                }
            }
        }
        .background(.main)
    }
    
    private func cell(for unit: Unit) -> some View {
        Button { [weak viewModel] in
            viewModel?.handleCellTap(for: unit)
        } label: {
            VStack(spacing: 10.0) {
                unit.thumbnail.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Asset.Colors.Base.white)
                    .frame(width: 40.0, height: 40.0)
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 14.0)
                    .background(unit.color.color)
                    .cornerRadius(8.0)
                Text(unit.title)
                    .foregroundColor(Asset.Colors.Base.white)
            }
            .padding(.vertical, 30.0)
            .padding(.horizontal, 5.0)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        RootView()
    }
}
