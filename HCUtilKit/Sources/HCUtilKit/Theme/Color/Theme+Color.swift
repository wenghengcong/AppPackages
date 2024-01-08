//
//  Theme+Color.swift
//  
//
//  Created by Nemo on 2024/1/8.
//

import SwiftUI

public extension Color {

    static var themeTint: Color {
        return themeShared.color(.tint)
    }

    static var themeBackground: Color {
        return themeShared.color(.background)
    }

    static var themeSecondaryText: Color {
        return themeShared.color(.secondaryText)
    }

    static var themeTertiaryText: Color {
        return themeShared.color(.tertiaryText)
    }
}
