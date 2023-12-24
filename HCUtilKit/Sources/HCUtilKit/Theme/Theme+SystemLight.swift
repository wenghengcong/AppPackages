//
//  Theme+SystemLight.swift
//  
//
//  Created by Nemo on 2023/12/23.
//

import SwiftUI

/// 系统普通模式
public extension Theme {
    static func systemLightColors(_ token: Theme.ColorToken) -> Color {

        switch token {
        case .background:
            return HCGlobalTokens.neutralColor(.grey96)
        case .backgroundPressed:
            return HCGlobalTokens.neutralColor(.white)
        case .backgroundSelected:
            return HCGlobalTokens.neutralColor(.white)
        case .backgroundDisabled:
            return HCGlobalTokens.neutralColor(.white)

        case .foreground:
            return HCGlobalTokens.neutralColor(.white)
        case .foregroundDisabled:
            return HCGlobalTokens.neutralColor(.white)
        case .foregroundOnColor:
            return HCGlobalTokens.neutralColor(.white)
        case .stroke:
            return HCGlobalTokens.neutralColor(.white)

        case .strokePressed:
            return HCGlobalTokens.neutralColor(.white)
        case .strokeFocus:
            return HCGlobalTokens.neutralColor(.white)
        case .strokeDisabled:
            return HCGlobalTokens.neutralColor(.grey88)
        case .tint:
            return HCGlobalTokens.brandColor(.tint)

        case .brandBackground:
            return HCGlobalTokens.brandColor(.tint)
        case .brandBackgroundPressed:
            return HCGlobalTokens.brandColor(.tint)
        case .brandBackgroundSelected:
            return HCGlobalTokens.brandColor(.tint)
        case .brandBackgroundTint:
            return HCGlobalTokens.brandColor(.tint)
        case .brandBackgroundDisabled:
            return HCGlobalTokens.neutralColor(.grey88)

        case .brandForeground:
            return HCGlobalTokens.brandColor(.tint)
        case .brandForegroundPressed:
            return HCGlobalTokens.brandColor(.tint)
        case .brandForegroundSelected:
            return HCGlobalTokens.brandColor(.tint)
        case .brandForegroundTint:
            return HCGlobalTokens.brandColor(.tint)

        case .brandForegroundDisabled:
            return HCGlobalTokens.brandColor(.tint)

        case .brandGradient:
            return HCGlobalTokens.brandColor(.gradientPrimaryLight)
        case .brandStroke:
            return HCGlobalTokens.brandColor(.tint)
        case .brandStrokePressed:
            return HCGlobalTokens.brandColor(.tint)
        case .brandStrokeSelected:
            return HCGlobalTokens.brandColor(.tint)

        case .dangerBackground:
            return HCGlobalTokens.sharedColor(.red, .tint60)
        case .dangerForeground:
            return HCGlobalTokens.sharedColor(.red, .shade10)
        case .dangerStroke:
            return HCGlobalTokens.sharedColor(.red, .tint20)

        case .successBackground:
            return HCGlobalTokens.sharedColor(.green, .tint60)
        case .successForeground:
            return HCGlobalTokens.sharedColor(.green, .shade10)
        case .successStroke:
            return HCGlobalTokens.sharedColor(.green, .tint20)

        case .warningBackground:
            return HCGlobalTokens.sharedColor(.yellow, .tint60)
        case .warningForeground:
            return HCGlobalTokens.sharedColor(.yellow, .shade30)
        case .warningStroke:
            return HCGlobalTokens.sharedColor(.yellow, .shade30)

        case .severeBackground:
            return HCGlobalTokens.sharedColor(.darkOrange, .tint60)
        case .severeForeground:
            return HCGlobalTokens.sharedColor(.darkOrange, .shade10)
        case .severeStroke:
            return HCGlobalTokens.sharedColor(.darkOrange, .tint10)
        }
    }

    static func systemLightShadows(_ token: ShadowToken) -> HCShadowInfo {
        switch token {
        case .clear:
            return HCShadowInfo(keyColor: .clear,
                              keyBlur: 0.0,
                              xKey: 0.0,
                              yKey: 0.0,
                              ambientColor: .clear,
                              ambientBlur: 0.0,
                              xAmbient: 0.0,
                              yAmbient: 0.0)
        case .shadow02:
            return HCShadowInfo(keyColor: Color(r: 0, g: 0, b: 0, alpha: 0.14),
                              keyBlur: 2,
                              xKey: 0,
                              yKey: 1,
                              ambientColor: Color(r: 0, g: 0, b: 0, alpha: 0.12),
                              ambientBlur: 2,
                              xAmbient: 0,
                              yAmbient: 0)
        case .shadow04:
            return HCShadowInfo(keyColor: Color(r: 0, g: 0, b: 0, alpha: 0.14),
                              keyBlur: 4,
                              xKey: 0,
                              yKey: 2,
                              ambientColor: Color(r: 0, g: 0, b: 0, alpha: 0.12),
                              ambientBlur: 2,
                              xAmbient: 0,
                              yAmbient: 0)
        case .shadow08:
            return HCShadowInfo(keyColor: Color(r: 0, g: 0, b: 0, alpha: 0.14),
                              keyBlur: 8,
                              xKey: 0,
                              yKey: 4,
                              ambientColor: Color(r: 0, g: 0, b: 0, alpha: 0.12),
                              ambientBlur: 2,
                              xAmbient: 0,
                              yAmbient: 0)
        case .shadow16:
            return HCShadowInfo(keyColor: Color(r: 0, g: 0, b: 0, alpha: 0.14),
                              keyBlur: 16,
                              xKey: 0,
                              yKey: 8,
                              ambientColor: Color(r: 0, g: 0, b: 0, alpha: 0.12),
                              ambientBlur: 2,
                              xAmbient: 0,
                              yAmbient: 0)
        case .shadow28:
            return HCShadowInfo(keyColor: Color(r: 0, g: 0, b: 0, alpha: 0.24),
                              keyBlur: 28,
                              xKey: 0,
                              yKey: 14,
                              ambientColor: Color(r: 0, g: 0, b: 0, alpha: 0.20),
                              ambientBlur: 8,
                              xAmbient: 0,
                              yAmbient: 0)
        case .shadow64:
            return HCShadowInfo(keyColor: Color(r: 0, g: 0, b: 0, alpha: 0.24),
                              keyBlur: 64,
                              xKey: 0,
                              yKey: 32,
                              ambientColor:Color(r: 0, g: 0, b: 0, alpha: 0.20),
                              ambientBlur: 8,
                              xAmbient: 0,
                              yAmbient: 0)
        }
    }

    static func systemLightTypography(_ token: TypographyToken) -> HCFontInfo {
        switch token {
        case .display:
            return .init(size: .size900, weight: .bold)
        case .largeTitle:
            return .init(size: .size800, weight: .bold)
        case .title1:
            return .init(size: .size700, weight: .bold)
        case .title2:
            return .init(size: .size600, weight: .semibold)
        case .title3:
            return .init(size: .size500, weight: .semibold)
        case .body1Strong:
            return .init(size: .size400, weight: .semibold)
        case .body1:
            return .init(size: .size400, weight: .regular)
        case .body2Strong:
            return .init(size: .size300, weight: .semibold)
        case .body2:
            return .init(size: .size300, weight: .regular)
        case .caption1Strong:
            return .init(size: .size200, weight: .semibold)
        case .caption1:
            return .init(size: .size200, weight: .regular)
        case .caption2:
            return .init(size: .size100, weight: .regular)
        }
    }

    /// Derives its default values from the theme's `HCColorTokenSet` values
    static func systemLightGradientColors(_ token: GradientToken, colorTokenSet: HCTokenSet<ColorToken, Color>) -> [Color] {
        switch token {
        case .flair:
            return [colorTokenSet[.brandGradient]]
        case .tint:
            return [colorTokenSet[.brandGradient]]
        }
    }

}
