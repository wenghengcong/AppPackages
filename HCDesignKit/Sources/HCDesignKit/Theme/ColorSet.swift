import SwiftUI

public let availableColorsSets: [HCColorSetCouple] =
[.init(light: SystemLight(), dark: SystemDark())]

public protocol ColorSet {
    var name: HCColorSetName { get }
    var scheme: HCColorScheme { get }
    var tintColor: Color { get set }
    var primaryBackgroundColor: Color { get set }
    var secondaryBackgroundColor: Color { get set }
    var labelColor: Color { get set }
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
    
    public let light: ColorSet
    public let dark: ColorSet
}

public struct SystemDark: ColorSet {
    public var name: HCColorSetName = .systemDark
    public var scheme: HCColorScheme = .dark
    public var tintColor: Color = .brand
    public var primaryBackgroundColor: Color = .init(red: 16 / 255, green: 21 / 255, blue: 35 / 255)
    public var secondaryBackgroundColor: Color = .init(red: 30 / 255, green: 35 / 255, blue: 62 / 255)
    public var labelColor: Color = .white
    
    public init() {}
}

public struct SystemLight: ColorSet {
    public var name: HCColorSetName = .systemLight
    public var scheme: HCColorScheme = .light
    public var tintColor: Color = .brand
    public var primaryBackgroundColor: Color = .white
    public var secondaryBackgroundColor: Color = .init(hex: 0xF0F1F2)
    public var labelColor: Color = .black
    
    public init() {}
}
