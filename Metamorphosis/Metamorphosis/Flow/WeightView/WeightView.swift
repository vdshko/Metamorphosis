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
        HStack {
            Spacer()
            VStack {
                Text("Weight")
                    .padding()
                Spacer()
            }
        }
        .background(.main)
    }
}

struct WeightView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeightView()
    }
}
