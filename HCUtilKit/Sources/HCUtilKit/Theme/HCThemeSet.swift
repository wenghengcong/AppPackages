import SwiftUI

public let availableThemeSets: [HCThemeCouple] =
[.init(light: ThemeSystemLight(), dark: ThemeSystemDark())]

/// 主题色彩集合
public protocol HCThemeSet {
    /// 主题名称
    var name: HCThemeName { get }
    /// 颜色模式
    var scheme: HCThemeScheme { get }
//    /// 主题色
//    var tintColor: Color { get set }
//    /// 主背景颜色
//    var primaryBackgroundColor: Color { get set }
//    /// 次背景颜色
//    var secondaryBackgroundColor: Color { get set }
//    /// 文本颜色
//    var labelColor: Color { get set }
//    /// 次要文本颜色
//    var sedondLabelColor: Color { get set }
//    /// 分割线颜色
//    var separatorColor: Color { get set }
//    /// 占位符颜色
//    var placeholderColor: Color { get set }

    var colorTokenSet: HCTokenSet<Theme.HCColorToken, Color> { get set }
    var shadowTokenSet: HCTokenSet<Theme.ShadowToken, HCShadowInfo> { get set }
    var typographyTokenSet: HCTokenSet<Theme.HCTypographyToken, HCFontInfo> { get set }
    var gradientTokenSet: HCTokenSet<Theme.HCGradientToken, [Color]> { get set }
}

public enum HCThemeScheme: String {
    case dark, light
}

public enum HCThemeName: String {
    case systemDark = "System Dark"
    case systemLight = "System Light"
}

public struct HCThemeCouple: Identifiable {
    public var id: String {
        dark.name.rawValue + light.name.rawValue
    }
    
    public let light: HCThemeSet
    public let dark: HCThemeSet
}

/// 参见Theme文件里的ThemeKey
public struct ThemeSystemDark: HCThemeSet {
    public var name: HCThemeName = .systemDark
    public var scheme: HCThemeScheme = .dark

    public var colorTokenSet: HCTokenSet<Theme.HCColorToken, Color>
    public var shadowTokenSet: HCTokenSet<Theme.ShadowToken, HCShadowInfo>
    public var typographyTokenSet: HCTokenSet<Theme.HCTypographyToken, HCFontInfo>
    public var gradientTokenSet: HCTokenSet<Theme.HCGradientToken, [Color]>
//    public var tintColor: Color = .brand
//    public var primaryBackgroundColor: Color = Color(hex: "#101010")
//    public var secondaryBackgroundColor: Color = Color(hex: "#1C1C1E")
//    public var labelColor: Color = .white
//    public var sedondLabelColor: Color = .white
//    public var separatorColor: Color = .white
//    public var placeholderColor: Color = .white
    public init() {
        let colorTokenSet = HCTokenSet<Theme.HCColorToken, Color>(Theme.defaultColors(_:))
        let shadowTokenSet = HCTokenSet<Theme.ShadowToken, HCShadowInfo>(Theme.defaultShadows(_:))
        let typographyTokenSet = HCTokenSet<Theme.HCTypographyToken, HCFontInfo>(Theme.defaultTypography(_:))
        let gradientTokenSet = HCTokenSet<Theme.HCGradientToken, [Color]>({ [colorTokenSet] token in
            // Reference the colorTokenSet as part of the gradient lookup
            return Theme.defaultGradientColors(token, colorTokenSet: colorTokenSet)
        })

        self.colorTokenSet = colorTokenSet
        self.shadowTokenSet = shadowTokenSet
        self.typographyTokenSet = typographyTokenSet
        self.gradientTokenSet = gradientTokenSet
    }
}

public struct ThemeSystemLight: HCThemeSet {
    public var name: HCThemeName = .systemLight
    public var scheme: HCThemeScheme = .light
    public var colorTokenSet: HCTokenSet<Theme.HCColorToken, Color>
    public var shadowTokenSet: HCTokenSet<Theme.ShadowToken, HCShadowInfo>
    public var typographyTokenSet: HCTokenSet<Theme.HCTypographyToken, HCFontInfo>
    public var gradientTokenSet: HCTokenSet<Theme.HCGradientToken, [Color]>
//    public var tintColor: Color = .brand
//    public var primaryBackgroundColor: Color = Color(hex: "#F6F6F6")
//    public var secondaryBackgroundColor: Color = Color.white
//    public var labelColor: Color = .black
//    public var sedondLabelColor: Color = .black
//    public var separatorColor: Color = .black
//    public var placeholderColor: Color = .black
    
    public init() {
        let colorTokenSet = HCTokenSet<Theme.HCColorToken, Color>(Theme.defaultColors(_:))
        let shadowTokenSet = HCTokenSet<Theme.ShadowToken, HCShadowInfo>(Theme.defaultShadows(_:))
        let typographyTokenSet = HCTokenSet<Theme.HCTypographyToken, HCFontInfo>(Theme.defaultTypography(_:))
        let gradientTokenSet = HCTokenSet<Theme.HCGradientToken, [Color]>({ [colorTokenSet] token in
            // Reference the colorTokenSet as part of the gradient lookup
            return Theme.defaultGradientColors(token, colorTokenSet: colorTokenSet)
        })

        self.colorTokenSet = colorTokenSet
        self.shadowTokenSet = shadowTokenSet
        self.typographyTokenSet = typographyTokenSet
        self.gradientTokenSet = gradientTokenSet
    }
}
