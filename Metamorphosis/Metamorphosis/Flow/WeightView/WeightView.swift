//
//  WeightView.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 07.04.2023.
//

import SwiftUI

struct WeightView: View {
    
    @StateObject var viewModel: WeightViewModel = WeightViewModel()
    
    var body: some View {
        VStack {
            topContainer
            conversionsList
            Spacer(minLength: 0.0)
        }
        .background(.main)
        .navigationTitle("Weight")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - topContainer
    
    @State private var inputViewFrame: CGRect = .zero
    @State private var isExpanded: Bool = false
    @FocusState private var isInputFieldFocused: Bool
    
    private var topContainer: some View {
        HStack {
            input
            selector
                .frame(width: inputViewFrame.width / Constants.dividerTopContainer)
        }
        .padding(Constants.paddingTopContainer)
        .reader(frame: $inputViewFrame)
        .zIndex(1)
    }
    
    private var input: some View {
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
        }
    }
    
    private var selector: some View {
        Button {
            toggleMeasurement()
        } label: {
            HStack {
                Text("\(viewModel.selectedMeasurement)")
                Spacer()
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(isExpanded ? 90.0 : 0.0))
            }
            .foregroundColor(Asset.Colors.Base.black)
            .padding(.horizontal, 10.0)
            .frame(width: inputViewFrame.width / Constants.dividerTopContainer)
            .padding(.vertical, 10.0)
            .background(Asset.Colors.Base.white.color)
            .cornerRadius(24.0)
        }
        .overlay(alignment: .top) {
            selectorList
        }
    }
    
    private var selectorList: some View {
        DisclosureGroup("", isExpanded: $isExpanded) {
            ScrollView {
                LazyVStack(spacing: 0.0) {
                    ForEach(1...100, id: \.self) { num in
                        HStack {
                            Text("\(num)")
                            Spacer()
                        }
                        .frame(height: 50.0)
                        .background(.secondary)
                        .onTapGesture { [weak viewModel] in
                            viewModel?.selectedMeasurement = num
                            toggleMeasurement()
                        }
                    }
                }
            }
            .padding(.horizontal, 10.0)
            .background(.secondary)
            .frame(maxHeight: UIScreen.main.bounds.height / 3)
        }
        .cornerRadius(24.0)
        .buttonStyle(HiddenButtonStyle())
        .offset(y: inputViewFrame.height - Constants.paddingTopContainer)
    }
    
    private func toggleMeasurement() {
        withAnimation {
            isInputFieldFocused = false
            isExpanded.toggle()
        }
    }
    
    // MARK: - conversionsList
    
    private var conversionsList: some View {
        List {
            ForEach(1...10, id: \.self) { num in
                HStack {
                    Spacer(minLength: 0.0)
                    Text("Measurement")
                        .padding(.horizontal, 10.0)
                    Text("\(num)")
                        .padding(.horizontal, 10.0)
                        .frame(width: inputViewFrame.width / Constants.dividerTopContainer, alignment: .leading)
                }
                .padding(.horizontal, Constants.paddingTopContainer)
                .frame(height: 50.0)
            }
            .listRowBackground(EmptyView().background(.main))
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

private extension WeightView {
    
    enum Constants {
        
        static let paddingTopContainer: CGFloat = 10.0
        static let dividerTopContainer: CGFloat = 3.0
    }
}

struct WeightView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeightView()
    }
}
