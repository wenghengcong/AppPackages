//
//  HCButtonTokenSet.swift
//  
//
//  Created by Nemo on 2023/12/22.
//

import Foundation
import SwiftUI

// MARK: ButtonStyle

func testButtonStyle() {
    let buttonStyle = HCButtonTokenSet(style: {
        return .outlineAccent
    }, size: {
        return .large
    })
    
    print(buttonStyle[.backgroundColor])
    print(buttonStyle[.cornerRadius])
}

public enum HCButtonStyle: Int, CaseIterable {
    // Added while we have deprecated styles. Can be removed once deprecated styles are removed.
    public static var allCases: [HCButtonStyle] = [accent,
                                                 outlineAccent,
                                                 outlineNeutral,
                                                 subtle,
                                                 danger,
                                                 dangerOutline,
                                                 dangerSubtle,
                                                 floatingAccent,
                                                 floatingSubtle]

    /// A button with no border, neutral foreground, and brand background.
    /// 无边框 / 主题背景色 / 中性前景色
    case accent

    /// A button with brand border, brand foreground, and no background.
    /// 有边框 / 主题 前景色 / 无背景色
    case outlineAccent

    /// A button with neutral border, neutral foreground, and no brackground.
    case outlineNeutral

    /// A button with no border, brand foreground, and no background.
    case subtle

    /// A button with no border, neutral foreground, and danger background.
    case danger

    /// A button with danger border, danger foreground, and no background.
    case dangerOutline

    /// A button with no border, danger foreground, and no background.
    case dangerSubtle

    /// A floating button with no border, neutral foreground, and brand background.
    case floatingAccent

    /// A floating button with no border, neutral foreground, and neutral background.
    case floatingSubtle

    public var isFloating: Bool {
        switch self {
        case .floatingAccent, .floatingSubtle:
            return true
        default:
            return false
        }
    }
}

// MARK: ButtonSizeCategory
public enum HCButtonSizeCategory: Int, CaseIterable {
    case large
    case medium
    case small
}

public enum HCButtonToken: Int, HCTokenSetKey {
    /// Defines the background color of the button
    case backgroundColor
    
    /// Defines the background color of the button when disabled
    case backgroundDisabledColor

    /// Defines the border color of the button
    case borderColor

    /// Defines the border color of the button when disabled
    case borderDisabledColor

    /// 按钮的高度
    case buttonHeight

    /// 按钮左/右边距
    case leading

    /// Defines the width of the border around the button
    case borderWidth

    /// Defines the radius of the corners of the button
    case cornerRadius

    /// Defines the colors of the text and icon of the button
    case foregroundColor

    /// Defines the colors of the text and icon of the button when disabled
    case foregroundDisabledColor

    /// Defines the font of the title of the button
    case titleFont

    /// Defines the shadow of the button
    case shadowRest

    /// Defines the shadow of the button when focused, disabled, or pressed
    case shadowPressed
}

/// Design token set for the `Button` control.
public class HCButtonTokenSet: HCControlTokenSet<HCButtonToken> {
    public init(style: @escaping () -> HCButtonStyle,
         size: @escaping () -> HCButtonSizeCategory) {
        self.style = style
        self.size = size
        super.init { [style, size] token, theme in
            switch token {
            case .backgroundColor:
                return .color {
                    switch style() {
                    case .accent, .floatingAccent:
                        return theme.color(.background)
                    case .outlineAccent, .outlineNeutral, .subtle, .dangerOutline, .dangerSubtle:
                        return .clear
                    case .danger:
                        return theme.color(.errorBackground)
                    case .floatingSubtle:
                        return theme.color(.background)
                    }
                }
                // HCTODO: brandBackgroundDisabled
            case .backgroundDisabledColor:
                return .color {
                    switch style() {
                    case .accent, .danger, .floatingAccent, .floatingSubtle:
                        return theme.color(.background)
                    case .outlineAccent, .outlineNeutral, .subtle, .dangerOutline, .dangerSubtle:
                        return .clear
                    }
                }
                // HCTODO: brandStroke
            case .borderColor:
                return .color {
                    switch style() {
                    case .accent, .subtle, .danger, .dangerSubtle, .floatingAccent, .floatingSubtle:
                        return .clear
                    case .outlineAccent:
                        return theme.color(.stroke)
                    case .outlineNeutral:
                        return theme.color(.stroke)
                    case .dangerOutline:
                        return theme.color(.errorForeground)
                    }
                }
                // HCTODO: strokeDisabled
            case .borderDisabledColor:
                return .color {
                    switch style() {
                    case .accent, .subtle, .danger, .dangerSubtle, .floatingAccent, .floatingSubtle:
                        return .clear
                    case .outlineAccent, .outlineNeutral, .dangerOutline:
                        return theme.color(.stroke)
                    }
                }
                
            case .buttonHeight:
                return .float {
                    if style().isFloating {
                        switch size() {
                        case .large:
                            return 56
                        case .medium, .small:
                            return 48
                        }
                    } else {
                        switch size() {
                        case .large:
                            return 52
                        case .medium:
                            return 40
                        case .small:
                            return 28
                        }
                    }
                }
            case .leading :
                return .float {
                    if style().isFloating {
                        switch size() {
                        case .large:
                            return 15
                        case .medium, .small:
                            return 15
                        }
                    } else {
                        switch size() {
                        case .large:
                            return 15
                        case .medium:
                            return 15
                        case .small:
                            return 15
                        }
                    }

                }
            case .borderWidth:
                return .float {
                    switch style() {
                    case .accent, .subtle, .danger, .dangerSubtle, .floatingAccent, .floatingSubtle:
                        return GlobalTokens.stroke(.widthNone)
                    case .outlineAccent, .outlineNeutral, .dangerOutline:
                        return GlobalTokens.stroke(.width10)
                    }
                }
            case .cornerRadius:
                return .float {
                    switch size() {
                    case .large:
                        return GlobalTokens.corner(.radius120)
                    case .medium, .small:
                        return GlobalTokens.corner(.radius80)
                    }
                }
                // HCTODO: brandForeground
            case .foregroundColor:
                return .color {
                    switch style() {
                    case .accent, .floatingAccent:
                        return theme.color(.foreground)
                    case  .outlineAccent, .subtle:
                        return theme.color(.foreground)
                    case .outlineNeutral:
                        return theme.color(.foreground)
                    case .danger:
                        return theme.color(.foreground)
                    case .dangerOutline, .dangerSubtle:
                        return theme.color(.errorForeground)
                    case .floatingSubtle:
                        return theme.color(.foreground)
                    }
                }
                // HCTODO: brandForegroundDisabled\brandForeground
            case .foregroundDisabledColor:
                return .color {
                    switch style() {
                    case .accent, .floatingAccent:
                        return theme.color(.foreground)
                    case  .outlineAccent, .subtle:
                        return theme.color(.foreground)
                    case .outlineNeutral:
                        return theme.color(.foreground)
                    case .danger:
                        return theme.color(.foreground)
                    case .dangerOutline, .dangerSubtle:
                        return theme.color(.errorForeground)
                    case .floatingSubtle:
                        return theme.color(.foreground)
                    }
                }
            case .titleFont:
                return .font {
                    switch size() {
                    case .large:
                        return theme.typography(.title3)
                    case .medium, .small:
                        return style().isFloating ? theme.typography(.body) : theme.typography(.caption)
                    }
                }
            case .shadowRest:
                return .shadowInfo { style().isFloating ? theme.shadow(.shadow08) : theme.shadow(.clear) }
            case .shadowPressed:
                return .shadowInfo { style().isFloating ? theme.shadow(.shadow02) : theme.shadow(.clear) }

            }
        }
    }

    var style: () -> HCButtonStyle
    var size: () -> HCButtonSizeCategory
}

extension HCButtonTokenSet {
    /// The value for the horizontal padding between the content of the button and the frame.
    static func horizontalPadding(style: HCButtonStyle, size: HCButtonSizeCategory) -> CGFloat {
        if style.isFloating {
            switch size {
            case .large:
                return GlobalTokens.spacing(.size16)
            case .medium, .small:
                return GlobalTokens.spacing(.size12)
            }
        } else {
            switch size {
            case .large:
                return GlobalTokens.spacing(.size20)
            case .medium:
                return GlobalTokens.spacing(.size12)
            case .small:
                return GlobalTokens.spacing(.size08)
            }
        }
    }

    /// The value for the right padding between the content of the button and the frame for a FAB button with an icon and text.
    static func fabAlternativePadding(_ size: HCButtonSizeCategory) -> CGFloat {
        switch size {
        case .large:
            return GlobalTokens.spacing(.size20)
        case .medium, .small:
            return GlobalTokens.spacing(.size16)
        }
    }

    /// The minimum value for the height of the content of the button.
    static func minContainerHeight(style: HCButtonStyle, size: HCButtonSizeCategory) -> CGFloat {
        if style.isFloating {
            switch size {
            case .large:
                return 56
            case .medium, .small:
                return 48
            }
        } else {
            switch size {
            case .large:
                return 52
            case .medium:
                return 40
            case .small:
                return 28
            }
        }
    }

    /// The value for the spacing between the title and image.
    static func titleImageSpacing(style: HCButtonStyle, size: HCButtonSizeCategory) -> CGFloat {
        if style.isFloating {
            return GlobalTokens.spacing(.size08)
        } else {
            switch size {
            case .large, .medium:
                return GlobalTokens.spacing(.size08)
            case .small:
                return GlobalTokens.spacing(.size04)
            }
        }
    }
}
