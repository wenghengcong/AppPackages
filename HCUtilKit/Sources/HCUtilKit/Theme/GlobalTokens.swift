//
//  GlobalTokens.swift
//
//
//  Created by Nemo on 2023/12/21.
//

import SwiftUI

/// Global Tokens represent a unified set of constants to be used by Fluent UI.
///
/// Values are derived from the Fluent UI design token system at
/// https://fluent2.microsoft.design/design-tokens
/// https://react.fluentui.dev/?path=/docs/theme-colors--page
public class GlobalTokens {
    
    // MARK: - BrandColor
    public enum BrandColorToken: Int, HCTokenSetKey {
        // Communication blue colors
        case tint
        case vip
        // Gradient colors
        case gradientPrimaryLight
        case gradientPrimaryDark
    }
    
    public static func brandColor(_ token: BrandColorToken) -> Color {
        switch token {
            
            // TODO: 主题色
        case .tint:
            return Color(hex: 0xFF4500)
            /*
             优酷会员：dbb57d
             知乎：e9be7b->b58540更深
             陌陌：f4bd64
             */
        case .vip:
            return Color(hex: 0xdbb57d)
        case .gradientPrimaryLight:
            return Color(hex: 0x464FEB)
        case .gradientPrimaryDark:
            return Color(hex: 0x7385FF)
        }
    }
    
    // MARK: - NeutralColor
    public enum NeutralColorToken: String, HCTokenSetKey {
        case black
        case gray2
        case gray4
        case gray6
        case gray7
        case gray8
        case gray10
        case gray11
        case gray12
        case gray14
        case gray16
        case gray18
        case gray20
        case gray22
        case gray24
        case gray26
        case gray28
        case gray30
        case gray32
        case gray34
        case gray36
        case gray38
        case gray40
        case gray42
        case gray44
        case gray46
        case gray48
        case gray50
        case gray52
        case gray54
        case gray56
        case gray58
        case gray60
        case gray62
        case gray64
        case gray66
        case gray68
        case gray70
        case gray72
        case gray74
        case gray76
        case gray78
        case gray80
        case gray82
        case gray84
        case gray86
        case gray88
        case gray90
        case gray92
        case gray94
        case gray96
        case gray98
        case white
    }
    
    public static func neutralColor(_ token: NeutralColorToken) -> Color {
        let colorName = token.rawValue
        return Color(colorName, bundle: .module)
    }
    
    // MARK: - SharedColor
    public enum SharedColorSet: String, HCTokenSetKey {
        case darkRed
        case burgundy
        case cranberry
        case red
        case darkOrange
        case bronze
        case pumpkin
        case orange
        case peach
        case marigold
        case yellow
        case gold
        case brass
        case brown
        case darkBrown
        case lime
        case forest
        case seafoam
        case lightGreen
        case green
        case darkGreen
        case lightTeal
        case teal
        case darkTeal
        case cyan
        case steel
        case lightBlue
        case blue
        case royalBlue
        case darkBlue
        case cornflower
        case navy
        case lavender
        case purple
        case darkPurple
        case orchid
        case grape
        case berry
        case lilac
        case pink
        case hotPink
        case magenta
        case plum
        case beige
        case mink
        case silver
        case platinum
        case anchor
        case charcoal
    }
    
    public enum SharedColorToken: String, HCTokenSetKey {
        case primary
        case tint10
        case tint20
        case tint30
        case tint40
        case tint50
        case tint60
        case shade50
        case shade40
        case shade30
        case shade20
        case shade10
    }
    
    public static func sharedColor(_ sharedColor: SharedColorSet, _ token: SharedColorToken) -> Color {
        let firstUpcase = token.rawValue.prefix(1).capitalized + token.rawValue.dropFirst()
        let colorName = "\(sharedColor)\(firstUpcase)"
        return Color(colorName, bundle: .module)
    }

    // MARK: - FontSize
    
    
    // MARK: - IconSize
    
    public enum IconSizeToken: HCTokenSetKey {
        case size100
        case size120
        case size160
        case size200
        case size240
        case size280
        case size360
        case size400
        case size480
    }
    public static func icon(_ token: IconSizeToken) -> CGFloat {
        switch token {
        case .size100:
            return 10
        case .size120:
            return 12
        case .size160:
            return 16
        case .size200:
            return 20
        case .size240:
            return 24
        case .size280:
            return 28
        case .size360:
            return 36
        case .size400:
            return 40
        case .size480:
            return 48
        }
    }
    
    // MARK: - Spacing
    
    public enum SpacingToken: HCTokenSetKey {
        case sizeNone
        case size02
        case size04
        case size06
        case size08
        case size10
        case size12
        case size16
        case size20
        case size24
        case size28
        case size32
        case size36
        case size40
        case size48
        case size52
        case size56
    }
    public static func spacing(_ token: SpacingToken) -> CGFloat {
        switch token {
        case .sizeNone:
            return 0
        case .size02:
            return 2
        case .size04:
            return 4
        case .size06:
            return 6
        case .size08:
            return 8
        case .size10:
            return 10
        case .size12:
            return 12
        case .size16:
            return 16
        case .size20:
            return 20
        case .size24:
            return 24
        case .size28:
            return 28
        case .size32:
            return 32
        case .size36:
            return 36
        case .size40:
            return 40
        case .size48:
            return 48
        case .size52:
            return 52
        case .size56:
            return 56
        }
    }
    
    // MARK: - BorderRadius
    public enum CornerRadiusToken: HCTokenSetKey {
        case radiusNone
        case radius20
        case radius40
        case radius60
        case radius80
        case radius120
        case radiusCircular
    }
    
    public static func corner(_ token: CornerRadiusToken) -> CGFloat {
        switch token {
        case .radiusNone:
            return 0
        case .radius20:
            return 2
        case .radius40:
            return 4
        case .radius60:
            return 6
        case .radius80:
            return 8
        case .radius120:
            return 12
        case .radiusCircular:
            return 9999
        }
    }
    
    // MARK: - BorderSize
    public enum StrokeWidthToken: HCTokenSetKey {
        case widthNone
        case width05
        case width10
        case width15
        case width20
        case width30
        case width40
        case width60
    }
    public static func stroke(_ token: StrokeWidthToken) -> CGFloat {
        switch token {
        case .widthNone:
            return 0
        case .width05:
            return 0.5
        case .width10:
            return 1
        case .width15:
            return 1.5
        case .width20:
            return 2
        case .width30:
            return 3
        case .width40:
            return 4
        case .width60:
            return 6
        }
    }
}

// MARK: Other
public extension Color {
    
    struct Gray {
        public static var level1 = Color.systemGray
        public static var level2 = Color.systemGray2
        public static var level3 = Color.systemGray3
        public static var level4 = Color.systemGray4
        public static var level5 = Color.systemGray5
        public static var level6 = Color.systemGray6
        public static var level7 = Color(rgb: (173, 180, 190))
        public static var level8 = Color(rgb: (196, 200, 208))
        public static var level9 = Color(rgb: (216, 220, 228))
    }
    
    
    struct DarkGray {
        public static var level1 = Color(rgb: (218, 220, 224))
        public static var level2 = Color(rgb: (198, 200, 204))
        public static var level3 = Color(rgb: (178, 180, 184))
        public static var level4 = Color(rgb: (158, 160, 164))
        public static var level5 = Color(rgb: (138, 140, 144))
        public static var level6 = Color(rgb: (118, 120, 124))
        public static var level7 = Color(rgb: (98, 100, 104))
        public static var level8 = Color(rgb: (78, 80, 84))
        public static var level9 = Color(rgb: (58, 60, 64))
    }
}

// MARK: Asset Colors
fileprivate extension Color {
    static var PrimaryBackground: Color {
        return Color("PrimaryBackground")
    }
    
    static var SecondaryBackground: Color {
        return Color("SecondaryBackground")
    }
    
    static var DarkBackground: Color {
        return Color("DarkBackground")
    }
    
    static var PrimaryText: Color {
        return Color("PrimaryText")
    }
    
    static var AlertRed: Color {
        return Color("AlertRed")
    }
    
    static var IncomeGreen: Color {
        return Color("IncomeGreen")
    }
    
    static var BudgetBackground: Color {
        return Color("BudgetBackground")
    }
    
    static var SubtitleText: Color {
        return Color("SubtitleText")
    }
    
    static var Outline: Color {
        return Color("Outline")
    }
    
    static var LightIcon: Color {
        return Color("LightIcon")
    }
    
    static var DarkIcon: Color {
        return Color("DarkIcon")
    }
    
    static var GrayIcon: Color {
        return Color("GrayIcon")
    }
    
    static var BudgetRed: Color {
        return Color("BudgetRed")
    }
    
    static var Alert: Color {
        return Color("Alert")
    }
    
    static var TertiaryBackground: Color {
        return Color("TertiaryBackground")
    }
    
    static var SettingsBackground: Color {
        return Color("Settings")
    }
    
    static var EvenLighterText: Color {
        return Color("EvenLighterText")
    }
}
