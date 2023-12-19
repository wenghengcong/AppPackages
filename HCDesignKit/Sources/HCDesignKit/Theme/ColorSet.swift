import SwiftUI

public let availableColorsSets: [HCColorSetCouple] =
[.init(light: SystemLight(), dark: SystemDark())]

/// 主题色彩集合
public protocol HCColorSet {
    /// 主题名称
    var name: HCColorSetName { get }
    /// 颜色模式
    var scheme: HCColorScheme { get }
    /// 主题色
    var tintColor: Color { get set }
    /// 主背景颜色
    var primaryBackgroundColor: Color { get set }
    /// 次背景颜色
    var secondaryBackgroundColor: Color { get set }
    /// 文本颜色
    var labelColor: Color { get set }
    /// 次要文本颜色
    var sedondLabelColor: Color { get set }
    /// 分割线颜色
    var separatorColor: Color { get set }
    /// 占位符颜色
    var placeholderColor: Color { get set }
}

public enum HCColorScheme: String {
    case dark, light
}

public enum HCColorSetName: String {
    case systemDark = "System Dark"
    case systemLight = "System Light"
}

public struct HCColorSetCouple: Identifiable {
    public var id: String {
        dark.name.rawValue + light.name.rawValue
    }
    
    public let light: HCColorSet
    public let dark: HCColorSet
}

/// 参见Theme文件里的ThemeKey
public struct SystemDark: HCColorSet {
    public var name: HCColorSetName = .systemDark
    public var scheme: HCColorScheme = .dark
    public var tintColor: Color = .brand
    public var primaryBackgroundColor: Color = Color(hex: "#101010")
    public var secondaryBackgroundColor: Color = Color(hex: "#1C1C1E")
    public var labelColor: Color = .white
    public var sedondLabelColor: Color = .white
    public var separatorColor: Color = .white
    public var placeholderColor: Color = .white
    public init() {}
}

public struct SystemLight: HCColorSet {
    public var name: HCColorSetName = .systemLight
    public var scheme: HCColorScheme = .light
    public var tintColor: Color = .brand
    public var primaryBackgroundColor: Color = Color(hex: "#F6F6F6")
    public var secondaryBackgroundColor: Color = Color.white
    public var labelColor: Color = .black
    public var sedondLabelColor: Color = .black
    public var separatorColor: Color = .black
    public var placeholderColor: Color = .black
    
    public init() {}
}
