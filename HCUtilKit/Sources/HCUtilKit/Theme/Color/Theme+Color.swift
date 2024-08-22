//
//  Theme+Color.swift
//  
//
//  Created by Nemo on 2024/1/8.
//

import SwiftUI

public extension Color {
    
    /// tintColor
    static var themeTint: Color {
        return themeShared.color(.tint)
    }
    
    // MARK: - Background
    /// 全局背景色：普通时：一般灰色
    static var themeBackground: Color {
        return themeShared.color(.background)
    }

    /// 全局背景色：普通时：一般是白色
    static var themeForeground: Color {
        return themeShared.color(.foreground)
    }
    
    /// tabbar背景色：普通时：一般是白色
    static var themeTabbarBackground: Color {
        return themeShared.color(.tabbarBackground)
    }


    // MARK: - 文本
    /// 第1文本色
    static var themePrimaryText: Color {
        return themeShared.color(.primaryText)
    }

    /// 第2文本色
    static var themeSecondaryText: Color {
        return themeShared.color(.secondaryText)
    }
    
    /// 第3文本色
    static var themeTertiaryText: Color {
        return themeShared.color(.tertiaryText)
    }

    // MARK: - ICON
    static var themeGrayIcon: Color {
        return themeShared.color(.grayIcon)
    }

    static var themeDarkIcon: Color {
        return themeShared.color(.darkIcon)
    }

    static var themeLightIcon: Color {
        return themeShared.color(.lightIcon)
    }
}
