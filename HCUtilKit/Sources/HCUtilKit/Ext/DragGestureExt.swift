//
//  File.swift
//  
//
//  Created by Nemo on 2023/10/27.
//

import Foundation
import SwiftUI

public extension View {
    func dismissingGesture(tolerance: Double = 24, action: @escaping (DragGesture.Value.SwipeDirection) -> ()) -> some View {
        gesture(DragGesture()
            .onEnded { value in
                if let swipeDirection = value.detectDirection(tolerance) {
                    action(swipeDirection)
                }
            }
        )
    }
}

public extension DragGesture.Value {
    func detectDirection(_ tolerance: Double = 24) -> SwipeDirection? {
        if startLocation.x < location.x - tolerance { return .left }
        if startLocation.x > location.x + tolerance { return .right }
        if startLocation.y > location.y + tolerance { return .up }
        if startLocation.y < location.y - tolerance { return .down }
        return nil
    }

    enum SwipeDirection {
        case left
        case right
        case up
        case down
    }
}
