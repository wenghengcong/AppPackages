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

    static var primaryBackground: Color {
        return Theme.shared.primaryBackgroundColor
    }
    
    static var secondaryBackground: Color {
        return Theme.shared.secondaryBackgroundColor
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
        public static var level7 = Color(rgb: (53, 60, 70))
        public static var level8 = Color(rgb: (53, 60, 70))
        public static var level9 = Color(rgb: (53, 60, 70))
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
