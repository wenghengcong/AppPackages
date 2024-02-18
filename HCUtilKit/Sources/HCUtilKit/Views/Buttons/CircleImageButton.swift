//
//  CircleImageButton.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/19.
//

import SwiftUI



@available(iOS 15.0, *)
public struct CircleImageButton: View {
    
    let size: Double
    let color: Color
    let action: () -> Void
    
    public var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                circle
                plus
            }
        }
    }
    
    var circle: some View {
        Circle()
            .frame(width: size)
            .foregroundStyle(color)
    }
    
    var plus: some View {
        Image(systemName: "plus")
            .font(.system(size: size / 2.3, weight: .semibold))
            .foregroundColor(.white)
    }
    
    /// A Circle-Shaped Plus Button. To initialize, just put your action inside the closure.
    /// You can also pass in custom Size and Color.
    public init(color: Color = .blue, size: Double = 55, action: @escaping () -> Void) {
        self.size = size
        self.color = color
        self.action = action
    }
}

@available(iOS 15.0, *)
#Preview {
    VStack {
        CircleImageButton(color: .cyan, size: 75, action: {
            
        })
    }
}
