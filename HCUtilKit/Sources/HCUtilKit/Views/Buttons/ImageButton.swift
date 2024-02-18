//
//  CircleImageButton.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/19.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ImageButton: View {
    
    let size: Double
    let color: Color
    let action: () -> Void
    
    public var body: some View {
        Button {
            action()
        } label: {
            image
        }
    }
    
    var image: some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(color)
            .font(.system(size: size))
            .accessibilityLabel("Dismiss")
    }
    
    /// This button is great for dismissing things like Sheets, Popovers or Cards.
    /// To initialize, just put your dismiss action inside the closure.
    /// You can also specify the Size and Color of the button.
    public init(size: Double = 27,
                color: Color = .gray.opacity(0.75),
                action: @escaping () -> Void) {
        
        self.size = size
        self.color = color
        self.action = action
    }
}

@available(iOS 15.0, *)
#Preview {
    VStack(spacing: 30) {
        ImageButton(size: 100) {}
        ImageButton(color: .purple) {}
    }
}
