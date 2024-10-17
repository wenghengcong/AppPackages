//
//  LocalizedStringKeyExtension.swift
//  HCUtilKit
//
//  Created by Nemo on 2024/10/17.
//

import Foundation
import SwiftUI

public extension LocalizedStringKey {
    public func toString() -> String {
        // 使用反射获取 LocalizedStringKey 的原始 key
        let mirror = Mirror(reflecting: self)
        if let key = mirror.children.first(where: { $0.label == "key" })?.value as? String {
            return NSLocalizedString(key, comment: "")
        }
        return ""
    }
}
