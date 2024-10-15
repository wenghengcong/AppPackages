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
            /// 主要的背景色，一般灰色
        case .background:
            return GlobalTokens.neutralColor(.gray96)

            /// 主要的前景色
        case .foreground:
            return GlobalTokens.neutralColor(.white)
            
        case .tabbarBackground:
            return GlobalTokens.neutralColor(.white)

        case .stroke:
            return GlobalTokens.neutralColor(.white)

        case .primaryText:
            return Color(assetName: "lightPrimaryText")
        case .secondaryText:
            return Color(assetName: "lightSecondaryText")
        case .tertiaryText:
            return Color(assetName: "lightTertiaryText")
        case .quaternaryLabel:
            return Color(assetName: "lightQuaternaryLabel")

        case .focusedBorder:
            return GlobalTokens.neutralColor(.gray92)
            
        case .tint:
            return GlobalTokens.brandColor(.tint)

        case .brandGradient:
            return GlobalTokens.brandColor(.gradientPrimaryLight)

        case .errorBackground:
            return GlobalTokens.sharedColor(.red, .tint60)
        case .errorForeground:
            return GlobalTokens.sharedColor(.red, .shade10)
        case .errorStroke:
            return GlobalTokens.sharedColor(.red, .tint20)

        case .successBackground:
            return GlobalTokens.sharedColor(.green, .tint60)
        case .successForeground:
            return GlobalTokens.sharedColor(.green, .shade10)
        case .successStroke:
            return GlobalTokens.sharedColor(.green, .tint20)

        case .warningBackground:
            return GlobalTokens.sharedColor(.yellow, .tint60)
        case .warningForeground:
            return GlobalTokens.sharedColor(.yellow, .shade30)
        case .warningStroke:
            return GlobalTokens.sharedColor(.yellow, .shade30)

        case .grayIcon:
            let iconColor = Color(assetName: "lightGrayIcon")
            return iconColor
        case .lightIcon:
            return Color(assetName: "lightLightIcon")
        case .darkIcon:
            return Color(assetName: "lightDarkIcon")
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

    /// 返回字体信息
    /// | token         |  size |
    /// | largeTitle    |  34   |
    /// | title         |  28   |
    /// | title2        |  22   |
    /// | title3        |  20   |
    /// | headline      |  17   |
    /// | subheadlin    |  15   |
    /// | body          |  17   |
    /// | callout       |  16   |
    /// | footnote      |  13   |
    /// | caption       |  12   |
    /// | caption2      |  11   |
    /// - Parameter token: token
    /// - Returns: 字体信息
    static func systemLightTypography(_ token: TypographyToken) -> HCFontInfo {        // 可以根据omMac判断是否需要的大小
        switch token {
        case .largeTitle:
            return .init(sizeToken: (HCFontSizeToken.onMac ? .size34 : .size34), weight: .regular)
        case .title:
            return .init(sizeToken: .size28, weight: .regular)
        case .title2:
            return .init(sizeToken: .size22, weight: .regular)
        case .title3:
            return .init(sizeToken: .size20, weight: .regular)
        case .headline:
            return .init(sizeToken: .size17, weight: .semibold)
        case .subheadline:
            return .init(sizeToken: .size15, weight: .regular)
        case .body:
            return .init(sizeToken: .size17, weight: .regular)
        case .callout:
            return .init(sizeToken: .size16, weight: .regular)
        case .footnote:
            return .init(sizeToken: .size13, weight: .regular)
        case .caption:
            return .init(sizeToken: .size12, weight: .regular)
        case .caption2:
            return .init(sizeToken: .size11, weight: .regular)
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
