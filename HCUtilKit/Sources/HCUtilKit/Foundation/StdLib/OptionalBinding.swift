//
//  File.swift
//  
//
//  Created by Nemo on 2024/9/16.
//

import Foundation
import SwiftUI

/// ?? 可选绑定
/// usage: TextField("", text: $text ?? "default value")
public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

/// 可选绑定
/*
 DatePicker(
     "My Title",
     selection: $myVar.bindUnwrap(defaultVal: Date()),
     in: ...Date(),
     displayedComponents: [.date]
 )
 */
public extension Binding {
    public func bindUnwrap<T>(defaultVal: T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: {
                self.wrappedValue ?? defaultVal
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}
