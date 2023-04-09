//
//  WeightView.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 07.04.2023.
//

import SwiftUI

struct WeightView: View {
    
    @StateObject var viewModel: WeightViewModel = WeightViewModel()
    @FocusState private var isInputFieldFocused: Bool
    
    var body: some View {
        VStack {
            inputView
            conversionsList
        }
        .background(.main)
        .navigationTitle("Weight")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var inputView: some View {
        HStack {
            Text("Input:")
                .foregroundColor(Asset.Colors.Base.white)
            TextField(
                "",
                value: $viewModel.inputValue,
                format: .number,
                prompt:
                    Text("value")
                    .foregroundColor(Asset.Colors.Base.white.color.opacity(0.6))
            )
            .foregroundColor(.white)
            .focused($isInputFieldFocused)
            .padding(10.0)
            .background(
                RoundedRectangle(cornerRadius: 24.0)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1.0))
                    .foregroundColor(.white)
            )
            
            DisclosureGroup("", isExpanded: $isExpanded) {
                VStack {
                    ForEach(1...10, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            
            Button {
                isInputFieldFocused = false
            } label: {
                Text("Unfocused")
                    .padding(10.0)
                    .background(.secondary)
                    .cornerRadius(24.0)
            }
        }
        .padding(10.0)
    }
    @State private var isExpanded: Bool = false
    private var conversionsList: some View {
        List {
            Text("start")
                .listRowBackground(EmptyView().background(.main))
        }
        .listStyle(.plain)
    }
}

struct WeightView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeightView()
    }
}
