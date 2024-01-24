//
//  Binding+Ext.swift
//  
//
//  Created by Nemo on 2024/1/24.
//

import SwiftUI

public extension Binding {
    /*
     解析可选值
     TextField("text.Something good...", text: $record.name.toUnwrapped(defaultValue: ""))
     */
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
