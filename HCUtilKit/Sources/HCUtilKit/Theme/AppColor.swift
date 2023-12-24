//
//  File.swift
//  
//
//  Created by Nemo on 2023/12/18.
//

import SwiftUI

// MARK: Main
public extension Color {
    /// 品牌主题色
    // TODO: 需要针对App更改
    static var brand: Color {
        Color(hex: 0xFF4500)
    }

    /*
     优酷会员：dbb57d
     知乎：e9be7b->b58540更深
     陌陌：f4bd64
     */
    static var vipColor: Color {
        Color(hex: "#dbb57d")
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
public extension Color {
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

    static var GreyIcon: Color {
        return Color("GreyIcon")
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
