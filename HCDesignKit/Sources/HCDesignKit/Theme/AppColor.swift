//
//  File.swift
//  
//
//  Created by Nemo on 2023/12/18.
//

import SwiftUI

public extension Color {
    
    /// 品牌主题色
    // TODO: 需要针对App更改
    static var brand: Color {
        Color(hex: 0xFF4500)
    }
    
    static var primaryBackground: Color {
        return Theme.shared.primaryBackgroundColor
    }
    
    static var secondaryBackground: Color {
        return Theme.shared.secondaryBackgroundColor
    }
    
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
