//
//  SetExtension.swift
//  HCUtilKit
//
//  Created by Nemo on 2024/10/22.
//

import Foundation

public extension NSSet {
    func toArray<T>() -> [T] {
        let array = self.map({ $0 as! T})
        return array
    }
}
