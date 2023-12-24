//
//  Theme+Set.swift
//  
//
//  Created by Nemo on 2023/12/23.
//

import SwiftUI

public let availableThemeSets: [Theme.ThemeCouple] =
[
    .init(light: Theme.SystemLight(), dark: Theme.SystemDark())
]

public protocol ThemeColorProperty {
    /// 主题色
    var tint: Color { get set }
    /// 主背景颜色
    var primaryBackground: Color { get set }
    /// 次背景颜色
    var secondaryBackground: Color { get set }
    /// 文本颜色
    var label: Color { get set }
    /// 次要文本颜色
    var sedondLabel: Color { get set }
    /// 分割线颜色
    var separator: Color { get set }
    /// 占位符颜色
    var placeholder: Color { get set }
}

/// 主题色彩集合
public protocol ThemeSet: ThemeColorProperty {
    /// 主题名称
    var name: Theme.ThemeName { get }
    /// 颜色模式
    var scheme: Theme.ThemeScheme { get }
    var colorTokenSet: HCTokenSet<Theme.ColorToken, Color> { get set }
    var shadowTokenSet: HCTokenSet<Theme.ShadowToken, HCShadowInfo> { get set }
    var typographyTokenSet: HCTokenSet<Theme.TypographyToken, HCFontInfo> { get set }
    var gradientTokenSet: HCTokenSet<Theme.GradientToken, [Color]> { get set }
}

public extension Theme {
    enum ThemeName: String {
        case systemDark = "System Dark"
        case systemLight = "System Light"
    }

    enum ThemeScheme: String {
        case dark
        case light
    }

    struct ThemeCouple: Identifiable {
        public var id: String {
            dark.name.rawValue + light.name.rawValue
        }

        public let light: ThemeSet
        public let dark: ThemeSet
    }
}

// MARK: - Themes
public extension Theme {
    /// 参见Theme文件里的ThemeKey
    struct SystemDark: ThemeSet {
        public var name: ThemeName = .systemDark
        public var scheme: ThemeScheme = .dark

        public var colorTokenSet: HCTokenSet<Theme.ColorToken, Color>
        public var shadowTokenSet: HCTokenSet<Theme.ShadowToken, HCShadowInfo>
        public var typographyTokenSet: HCTokenSet<Theme.TypographyToken, HCFontInfo>
        public var gradientTokenSet: HCTokenSet<Theme.GradientToken, [Color]>

        // MARK: - 常用颜色
        public var tint: Color
        public var primaryBackground: Color
        public var secondaryBackground: Color
        public var label: Color
        public var sedondLabel: Color
        public var separator: Color
        public var placeholder: Color

        public init() {
            let colorTokenSet = HCTokenSet<Theme.ColorToken, Color>(Theme.systemDarkColors(_:))
            let shadowTokenSet = HCTokenSet<Theme.ShadowToken, HCShadowInfo>(Theme.systemDarkShadows(_:))
            let typographyTokenSet = HCTokenSet<Theme.TypographyToken, HCFontInfo>(Theme.systemDarkTypography(_:))
            let gradientTokenSet = HCTokenSet<Theme.GradientToken, [Color]>({ [colorTokenSet] token in
                // Reference the colorTokenSet as part of the gradient lookup
                return Theme.systemDarkGradientColors(token, colorTokenSet: colorTokenSet)
            })

            self.colorTokenSet = colorTokenSet
            self.shadowTokenSet = shadowTokenSet
            self.typographyTokenSet = typographyTokenSet
            self.gradientTokenSet = gradientTokenSet

            self.tint = colorTokenSet[.tint]
            self.primaryBackground = colorTokenSet[.tint]
            self.secondaryBackground = colorTokenSet[.tint]
            self.label = colorTokenSet[.tint]
            self.sedondLabel = colorTokenSet[.tint]
            self.separator = colorTokenSet[.tint]
            self.placeholder = colorTokenSet[.tint]
        }
    }

    struct SystemLight: ThemeSet {
        public var name: ThemeName = .systemLight
        public var scheme: ThemeScheme = .light

        public var colorTokenSet: HCTokenSet<Theme.ColorToken, Color>
        public var shadowTokenSet: HCTokenSet<Theme.ShadowToken, HCShadowInfo>
        public var typographyTokenSet: HCTokenSet<Theme.TypographyToken, HCFontInfo>
        public var gradientTokenSet: HCTokenSet<Theme.GradientToken, [Color]>

        // MARK: - 常用颜色
        public var tint: Color
        public var primaryBackground: Color
        public var secondaryBackground: Color
        public var label: Color
        public var sedondLabel: Color
        public var separator: Color
        public var placeholder: Color

        public init() {
            let colorTokenSet = HCTokenSet<Theme.ColorToken, Color>(Theme.systemLightColors(_:))
            let shadowTokenSet = HCTokenSet<Theme.ShadowToken, HCShadowInfo>(Theme.systemLightShadows(_:))
            let typographyTokenSet = HCTokenSet<Theme.TypographyToken, HCFontInfo>(Theme.systemLightTypography(_:))
            let gradientTokenSet = HCTokenSet<Theme.GradientToken, [Color]>({ [colorTokenSet] token in
                // Reference the colorTokenSet as part of the gradient lookup
                return Theme.systemLightGradientColors(token, colorTokenSet: colorTokenSet)
            })
            self.colorTokenSet = colorTokenSet
            self.shadowTokenSet = shadowTokenSet
            self.typographyTokenSet = typographyTokenSet
            self.gradientTokenSet = gradientTokenSet

            self.tint = colorTokenSet[.tint]
            self.primaryBackground = colorTokenSet[.tint]
            self.secondaryBackground = colorTokenSet[.tint]
            self.label = colorTokenSet[.tint]
            self.sedondLabel = colorTokenSet[.tint]
            self.separator = colorTokenSet[.tint]
            self.placeholder = colorTokenSet[.tint]
        }
    }
}

