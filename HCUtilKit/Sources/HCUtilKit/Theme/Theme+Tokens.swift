//
//  Theme+Tokens.swift
//  
//
//  Created by Nemo on 2023/12/22.
//

import Foundation
import SwiftUI

public extension Theme {
    enum HCGradientToken: Int, HCTokenSetKey {
        case flair
        case tint
    }

    enum HCColorToken: Int, HCTokenSetKey {
        // Neutral colors - Background
        case background1
        case background1Pressed
        case background1Selected
        case background2
        case background2Pressed
        case background2Selected
        case background3
        case background3Pressed
        case background3Selected
        case background4
        case background4Pressed
        case background4Selected
        case background5
        case background5Pressed
        case background5Selected
        case background6
        case backgroundCanvas
        case backgroundDarkStatic
        case backgroundLightStatic
        case backgroundLightStaticDisabled
        case backgroundInverted
        case backgroundDisabled
        case stencil1
        case stencil2

        // Neutral colors - Foreground
        case foreground1
        case foreground2
        case foreground3
        case foregroundDisabled1
        case foregroundDisabled2
        case foregroundOnColor
        case foregroundDarkStatic
        case foregroundLightStatic

        // Neutral colors - Stroke
        case stroke1
        case stroke1Pressed
        case stroke2
        case strokeAccessible
        case strokeFocus1
        case strokeFocus2
        case strokeDisabled

        // Brand colors - Brand background
        case brandBackground1
        case brandBackground1Pressed
        case brandBackground1Selected
        case brandBackground2
        case brandBackground2Pressed
        case brandBackground2Selected
        case brandBackground3
        case brandBackgroundTint
        case brandBackgroundDisabled

        // Brand colors - Brand foreground
        case brandForeground1
        case brandForeground1Pressed
        case brandForeground1Selected
        case brandForegroundTint
        case brandForegroundDisabled1
        case brandForegroundDisabled2

        // Brand colors - Brand gradient
        case brandGradient1
        case brandGradient2
        case brandGradient3

        // Brand colors - Brand stroke
        case brandStroke1
        case brandStroke1Pressed
        case brandStroke1Selected

        // Shared colors - Error & Status
        case dangerBackground1
        case dangerBackground2
        case dangerForeground1
        case dangerForeground2
        case dangerStroke1
        case dangerStroke2
        case successBackground1
        case successBackground2
        case successForeground1
        case successForeground2
        case successStroke1
        case warningBackground1
        case warningBackground2
        case warningForeground1
        case warningForeground2
        case warningStroke1
        case severeBackground1
        case severeBackground2
        case severeForeground1
        case severeForeground2
        case severeStroke1

        // Shared colors - Presence
        case presenceAway
        case presenceDnd
        case presenceAvailable
        case presenceOof
    }

    enum ShadowToken: Int, HCTokenSetKey {
        case clear
        case shadow02
        case shadow04
        case shadow08
        case shadow16
        case shadow28
        case shadow64
    }

    enum HCTypographyToken: Int, HCTokenSetKey {
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

    /// Returns the color value for the given token.
    ///
    /// - Parameter token: The `ColorsTokens` value to be retrieved.
    /// - Returns: A `Color` for the given token.
    func color(_ token: HCColorToken) -> Color {
        return colorTokenSet[token]
    }

    /// Returns the shadow value for the given token.
    ///
    /// - Parameter token: The `ShadowTokens` value to be retrieved.
    /// - Returns: A `HCShadowInfo` for the given token.
    func shadow(_ token: ShadowToken) -> HCShadowInfo {
        return shadowTokenSet[token]
    }

    /// Returns the font value for the given token.
    ///
    /// - Parameter token: The `TypographyTokens` value to be retrieved.
    /// - Parameter adjustsForContentSizeCategory: If true, the resulting font will change size according to Dynamic Type specifications.
    /// - Returns: A `UIFont` for the given token.
    func typography(_ token: HCTypographyToken, adjustsForContentSizeCategory: Bool = true) -> Font {
        return Font.info(typographyTokenSet[token],
                             shouldScale: adjustsForContentSizeCategory)
    }

    /// Returns the font value for the given token.
    ///
    /// - Parameter token: The `TypographyTokens` value to be retrieved.
    /// - Parameter adjustsForContentSizeCategory: If true, the resulting font will change size according to Dynamic Type specifications.
    /// - Parameter contentSizeCategory: An overridden `UIContentSizeCategory` to conform to.
    /// - Returns: A `UIFont` for the given token.
    func typography(_ token: HCTypographyToken,
                    adjustsForContentSizeCategory: Bool = true,
                    contentSizeCategory: UIContentSizeCategory) -> Font {
        return Font.info(typographyTokenSet[token],
                             shouldScale: adjustsForContentSizeCategory,
                             contentSizeCategory: contentSizeCategory)
    }

    /// Returns an array of colors for the given token.
    ///
    /// - Parameter token: The `HCGradientTokens` value to be retrieved.
    /// - Returns: An array of `Color` values for the given token.
    func gradient(_ token: HCGradientToken) -> [Color] {
        return gradientTokenSet[token]
    }
}

extension Theme {
    static func defaultColors(_ token: Theme.HCColorToken) -> Color {
        switch token {
        case .foreground1:
            return HCGlobalTokens.neutralColor(.grey14)
        case .foreground2:
            return HCGlobalTokens.neutralColor(.grey38)
        case .foreground3:
            return HCGlobalTokens.neutralColor(.grey50)
        case .foregroundDisabled1:
            return HCGlobalTokens.neutralColor(.grey74)
        case .foregroundDisabled2:
            return HCGlobalTokens.neutralColor(.white)
        case .foregroundOnColor:
            return HCGlobalTokens.neutralColor(.white)
        case .brandForegroundTint:
            return HCGlobalTokens.brandColor(.comm60)
        case .brandForeground1:
            return HCGlobalTokens.brandColor(.comm80)
        case .brandForeground1Pressed:
            return HCGlobalTokens.brandColor(.comm50)
        case .brandForeground1Selected:
            return HCGlobalTokens.brandColor(.comm60)
        case .brandForegroundDisabled1:
            return HCGlobalTokens.brandColor(.comm90)
        case .brandForegroundDisabled2:
            return HCGlobalTokens.brandColor(.comm140)
        case .brandGradient1:
            return HCGlobalTokens.brandColor(.gradientPrimaryLight)
        case .brandGradient2:
            return HCGlobalTokens.brandColor(.gradientSecondaryLight)
        case .brandGradient3:
            return HCGlobalTokens.brandColor(.gradientTertiaryLight)
        case .foregroundDarkStatic:
            return HCGlobalTokens.neutralColor(.black)
        case .foregroundLightStatic:
            return HCGlobalTokens.neutralColor(.white)
        case .background1:
            return HCGlobalTokens.neutralColor(.white)
        case .background1Pressed:
            return HCGlobalTokens.neutralColor(.grey88)
        case .background1Selected:
            return HCGlobalTokens.neutralColor(.grey92)
        case .background2:
            return HCGlobalTokens.neutralColor(.white)
        case .background2Pressed:
            return HCGlobalTokens.neutralColor(.grey88)
        case .background2Selected:
            return HCGlobalTokens.neutralColor(.grey92)
        case .background3:
            return HCGlobalTokens.neutralColor(.white)
        case .background3Pressed:
            return HCGlobalTokens.neutralColor(.grey88)
        case .background3Selected:
            return HCGlobalTokens.neutralColor(.grey92)
        case .background4:
            return HCGlobalTokens.neutralColor(.grey98)
        case .background4Pressed:
            return HCGlobalTokens.neutralColor(.grey86)
        case .background4Selected:
            return HCGlobalTokens.neutralColor(.grey90)
        case .background5:
            return HCGlobalTokens.neutralColor(.grey94)
        case .background5Pressed:
            return HCGlobalTokens.neutralColor(.grey82)
        case .background5Selected:
            return HCGlobalTokens.neutralColor(.grey86)
        case .background6:
            return HCGlobalTokens.neutralColor(.grey82)
        case .backgroundDisabled:
            return HCGlobalTokens.neutralColor(.grey88)
        case .brandBackgroundTint:
            return HCGlobalTokens.brandColor(.comm150)
        case .brandBackground1:
            return HCGlobalTokens.brandColor(.comm80)
        case .brandBackground1Pressed:
            return HCGlobalTokens.brandColor(.comm50)
        case .brandBackground1Selected:
            return HCGlobalTokens.brandColor(.comm60)
        case .brandBackground2:
            return HCGlobalTokens.brandColor(.comm70)
        case .brandBackground2Pressed:
            return HCGlobalTokens.brandColor(.comm40)
        case .brandBackground2Selected:
            return HCGlobalTokens.brandColor(.comm80)
        case .brandBackground3:
            return HCGlobalTokens.brandColor(.comm60)
        case .brandBackgroundDisabled:
            return HCGlobalTokens.brandColor(.comm140)
        case .stencil1:
            return HCGlobalTokens.neutralColor(.grey90)
        case .stencil2:
            return HCGlobalTokens.neutralColor(.grey98)
        case .backgroundCanvas:
            return HCGlobalTokens.neutralColor(.grey96)
        case .backgroundDarkStatic:
            return HCGlobalTokens.neutralColor(.grey14)
        case .backgroundInverted:
            return HCGlobalTokens.neutralColor(.grey46)
        case .backgroundLightStatic:
            return HCGlobalTokens.neutralColor(.white)
        case .backgroundLightStaticDisabled:
            return HCGlobalTokens.neutralColor(.white)
        case .stroke1:
            return HCGlobalTokens.neutralColor(.grey82)
        case .stroke1Pressed:
            return HCGlobalTokens.neutralColor(.grey70)
        case .stroke2:
            return HCGlobalTokens.neutralColor(.grey88)
        case .strokeAccessible:
            return HCGlobalTokens.neutralColor(.grey38)
        case .strokeFocus1:
            return HCGlobalTokens.neutralColor(.white)
        case .strokeFocus2:
            return HCGlobalTokens.neutralColor(.black)
        case .strokeDisabled:
            return HCGlobalTokens.neutralColor(.grey88)
        case .brandStroke1:
            return HCGlobalTokens.brandColor(.comm80)
        case .brandStroke1Pressed:
            return HCGlobalTokens.brandColor(.comm50)
        case .brandStroke1Selected:
            return HCGlobalTokens.brandColor(.comm60)
        case .dangerBackground1:
            return HCGlobalTokens.sharedColor(.red, .tint60)
        case .dangerBackground2:
            return HCGlobalTokens.sharedColor(.red, .primary)
        case .dangerForeground1:
            return HCGlobalTokens.sharedColor(.red, .shade10)
        case .dangerForeground2:
            return HCGlobalTokens.sharedColor(.red, .primary)
        case .dangerStroke1:
            return HCGlobalTokens.sharedColor(.red, .tint20)
        case .dangerStroke2:
            return HCGlobalTokens.sharedColor(.red, .primary)
        case .successBackground1:
            return HCGlobalTokens.sharedColor(.green, .tint60)
        case .successBackground2:
            return HCGlobalTokens.sharedColor(.green, .primary)
        case .successForeground1:
            return HCGlobalTokens.sharedColor(.green, .shade10)
        case .successForeground2:
            return HCGlobalTokens.sharedColor(.green, .primary)
        case .successStroke1:
            return HCGlobalTokens.sharedColor(.green, .tint20)
        case .severeBackground1:
            return HCGlobalTokens.sharedColor(.darkOrange, .tint60)
        case .severeBackground2:
            return HCGlobalTokens.sharedColor(.darkOrange, .primary)
        case .severeForeground1:
            return HCGlobalTokens.sharedColor(.darkOrange, .shade10)
        case .severeForeground2:
            return HCGlobalTokens.sharedColor(.darkOrange, .shade20)
        case .severeStroke1:
            return HCGlobalTokens.sharedColor(.darkOrange, .tint10)
        case .warningBackground1:
            return HCGlobalTokens.sharedColor(.yellow, .tint60)
        case .warningBackground2:
            return HCGlobalTokens.sharedColor(.yellow, .primary)
        case .warningForeground1:
            return HCGlobalTokens.sharedColor(.yellow, .shade30)
        case .warningForeground2:
            return HCGlobalTokens.sharedColor(.yellow, .shade30)
        case .warningStroke1:
            return HCGlobalTokens.sharedColor(.yellow, .shade30)
        case .presenceAway:
            return HCGlobalTokens.sharedColor(.marigold, .primary)
        case .presenceDnd:
            return HCGlobalTokens.sharedColor(.red, .primary)
        case .presenceAvailable:
            return HCGlobalTokens.sharedColor(.lightGreen, .primary)
        case .presenceOof:
            return HCGlobalTokens.sharedColor(.berry, .primary)
        }
    }

    static func defaultShadows(_ token: ShadowToken) -> HCShadowInfo {
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

    static func defaultTypography(_ token: HCTypographyToken) -> HCFontInfo {
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
    static func defaultGradientColors(_ token: HCGradientToken, colorTokenSet: HCTokenSet<HCColorToken, Color>) -> [Color] {
        switch token {
        case .flair:
            return [colorTokenSet[.brandGradient1],
                    colorTokenSet[.brandGradient2],
                    colorTokenSet[.brandGradient3]]
        case .tint:
            return [colorTokenSet[.brandGradient2],
                    colorTokenSet[.brandGradient3]]
        }
    }

}
