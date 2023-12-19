//
//  ViewExt.swift
//
//
//  Created by Nemo on 2023/10/27.
//

import SwiftUI

public extension View {
    @ViewBuilder func active(if condition: Bool) -> some View {
        if condition { self }
    }
}

public extension View {
    func frame(_ size: CGFloat) -> some View { frame(width: size, height: size, alignment: .center) }
}

public extension View {
    func alignHorizontally(_ alignment: HorizontalAlignment, _ value: CGFloat = 0) -> some View {
        HStack(spacing: 0) {
            Spacer.width(alignment == .leading ? value : nil)
            self
            Spacer.width(alignment == .trailing ? value : nil)
        }
    }
}
