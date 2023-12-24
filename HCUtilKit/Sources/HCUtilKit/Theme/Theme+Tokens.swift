//
//  Theme+Tokens.swift
//  
//
//  Created by Nemo on 2023/12/22.
//

import Foundation
import SwiftUI

public extension Theme {
    
    /// 主题
    enum ThemeToken: String {
        /// dark 还是 light
        case scheme
        /// 是否根据系统设置dark/light
        case followSystemScheme
        /// 选中的主题名
        case name
    }

    enum GradientToken: String, HCTokenSetKey {
        case flair
        case tint
    }

    enum ColorToken: String, HCTokenSetKey {
        // Neutral colors - Background
        case background
        case backgroundPressed
        case backgroundSelected
        case backgroundDisabled

        // Neutral colors - Foreground
        case foreground
        case foregroundDisabled
        case foregroundOnColor

        // Neutral colors - Stroke
        case stroke
        case strokePressed
        case strokeFocus
        case strokeDisabled

        // Brand colors - Brand background
        case tint
        case brandBackground
        case brandBackgroundPressed
        case brandBackgroundSelected
        case brandBackgroundTint
        case brandBackgroundDisabled

        // Brand colors - Brand foreground
        case brandForeground
        case brandForegroundPressed
        case brandForegroundSelected
        case brandForegroundTint
        case brandForegroundDisabled

        // Brand colors - Brand gradient
        case brandGradient

        // Brand colors - Brand stroke
        case brandStroke
        case brandStrokePressed
        case brandStrokeSelected

        // Shared colors - Error & Status
        case dangerBackground
        case dangerForeground
        case dangerStroke

        case successBackground
        case successForeground
        case successStroke

        case warningBackground
        case warningForeground
        case warningStroke

        case severeBackground
        case severeForeground
        case severeStroke
    }

    enum ShadowToken: String, HCTokenSetKey {
        case clear
        case shadow02
        case shadow04
        case shadow08
        case shadow16
        case shadow28
        case shadow64
    }

    enum TypographyToken: String, HCTokenSetKey {
        case display
        case largeTitle
        case title1
        case title2
        case title3
        case body1Strong
        case body1
        case body2Strong
        case body2
        case caption1Strong
        case caption1
        case caption2
    }
}
