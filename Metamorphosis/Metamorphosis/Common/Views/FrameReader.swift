//
//  FrameReader.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 09.04.2023.
//

import SwiftUI

private struct FrameReader: ViewModifier {
    
    @Binding var frame: CGRect
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    DispatchQueue.main.async {
                        let rect: CGRect = proxy.frame(in: .global)
                        if frame != rect {
                            frame = rect
                        }
                    }
                    
                    return AnyView(EmptyView())
                }
            )
    }
}

extension View {

    func reader(frame: Binding<CGRect>) -> some View {
        return modifier(FrameReader(frame: frame))
    }
}
