//
//  Theme+Tokens.swift
//  
//
//  Created by Nemo on 2023/12/22.
//

import Foundation
import SwiftUI

public extension Theme {
    
    // MARK: - 主题
    enum ThemeToken: String {
        /// dark 还是 light
        case scheme
        /// 是否根据系统设置dark/light
        case followSystemScheme
        /// 选中的主题名
        case name
    }

    // MARK: - 渐变
    enum GradientToken: String, HCTokenSetKey {
        case flair
        case tint
    }

    // MARK: - 颜色
    /// 各种颜色token
    enum ColorToken: String, HCTokenSetKey {
        // Brand colors - Brand background
        /// 主题色，即品牌色
        case tint

        // Neutral colors - Background
        /// 全局普通背景：一般是灰色
        case background

        // Neutral colors - Foreground
        /// 全局普通前景：区分与背景色，一般是白色
        case foreground

        case tabbarBackground

        case grayIcon
        case lightIcon
        case darkIcon

        /// 第1级：Primary text content (e.g.titles)
        case primaryText
        /// 第2级：Secondary text content (subtitles, section headers)
        case secondaryText
        /// 第3级：Tertiary text content (footnotes, statuses)
        case tertiaryText
        /// 第4级：Non-interactive icons and symbols
        case quaternaryLabel
        
        /// 输入框焦点的边框色
        case focusedBorder
        
        // Neutral colors - Stroke
        case stroke

        // Brand colors - Brand gradient
        case brandGradient

        // Shared colors - Error & Status
        case errorBackground
        case errorForeground
        case errorStroke

        case successBackground
        case successForeground
        case successStroke

        case warningBackground
        case warningForeground
        case warningStroke
    }

    // MARK: - 阴影
    enum ShadowToken: String, HCTokenSetKey {
        case clear
        case shadow02
        case shadow04
        case shadow08
        case shadow16
        case shadow28
        case shadow64
    }

    // MARK: - 字体
    /// 字体token（包含字体size\weight\textstyle)
    enum TypographyToken: String, HCTokenSetKey {
        // MARK: 字体-系统标准样式
        /// large titles
        /// ——> 34
        case largeTitle
        /// The font used for first level hierarchical headings.
        /// ——> 28
        case title
        /// The font used for second level hierarchical headings.
        /// ——> 22
        case title2
        /// The font used for third level hierarchical headings.
        /// ——> 20
        case title3
        /// The font used for headings.
        /// ——> 17
        case headline
        /// The font used for subheadings.
        /// ——> 15
        case subheadline
        /// The font used for body text.
        /// ——> 17
        case body
        /// The font used for callouts.
        /// ——> 16
        case callout
        /// The font used in footnotes.
        /// ——> 13
        case footnote
        /// The font used for standard captions.
        /// ——> 12
        case caption
        /// The font used for alternate captions.
        /// ——> 11
        case caption2
        // MARK: 字体-自定义样式
    }
}
