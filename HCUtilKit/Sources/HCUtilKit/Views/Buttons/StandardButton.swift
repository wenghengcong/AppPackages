//
//  StandardButton.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/19.
//

import SwiftUI

@available(iOS 15.0, *)
public struct StandardButton: View {
    
    let title: String
    let style: HCButtonStyle
    let size: HCButtonSizeCategory
    let action: () -> Void
    @Binding var disable: Bool

    private  var tokenSet: HCButtonTokenSet
    
    public var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                background
                text
            }
        }
    }
    
    var background: some View {
        Rectangle()
            .frame(height: tokenSet[.buttonHeight].float)
            .foregroundColor((disable ? tokenSet[.backgroundDisabledColor].color : tokenSet[.backgroundColor].color))
            .cornerRadius(tokenSet[.cornerRadius].float)
            .padding(.leading, tokenSet[.leading].float)
            .padding(.trailing, tokenSet[.leading].float)
    }
    
    var text: some View {
        Text(title)
            .font(tokenSet[.titleFont].font)
            .lineLimit(1)
            .foregroundColor(tokenSet[.foregroundColor].color)
            .padding(.horizontal)
    }
    
    /// A Simple Button that can be used anywhere throughout the app.
    /// You initialize it just like the standard SwiftUI Button, by passing in the title and action.
    /// For more customization, pass in Custom Color, Corner Radius, Font and Height.
    public init(_ title: String,
                style: HCButtonStyle,
                size: HCButtonSizeCategory,
                disable: Binding<Bool>? = nil,
                action: @escaping () -> Void) {
        self.style = style
        self.size = size
        self.tokenSet = HCButtonTokenSet {
            style
        } size: {
            size
        }
        self.title = title
        self.action = action
        _disable = disable ?? Binding.constant(false)
    }
}

@available(iOS 15.0, *)
#Preview {
    
    VStack(spacing: 30) {
        StandardButton("Accent Large", style: .accent, size: .large, action: {})
        StandardButton("Accent Medium", style: .accent, size: .medium, action: {})
        StandardButton("Accent Small", style: .accent, size: .small, action: {})

        StandardButton("Accent Small", style: .accent, size: .large, disable: .constant(true), action: {})

    }
    .padding(.horizontal, 25)
}
