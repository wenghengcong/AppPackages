//
//  String+Ext.swift
//  
//
//  Created by Nemo on 2024/1/7.
//

import SwiftUI
import Foundation
import UIKit

public extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}

public extension String {
    func onlyEmoji() -> String {
        return filter { $0.isEmoji }
    }
}
