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
                .navigationDestination(for: NavigationType.self) { type in
                    switch type {
                    default:
                        Text(L10n.Common.comingSoon)
                    }
                }
        }
    }
    
    var content: some View {
        ZStack {
            Asset.Colors.Background.main.color.ignoresSafeArea()
            LazyVGrid(columns: gridColumns, spacing: 60.0) {
                ForEach(viewModel.units, id: \.self) { unit in
                    cell(for: unit)
                }
            }
        }
    }
    
    func cell(for unit: Unit) -> some View {
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
        }
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        RootView()
    }
}
