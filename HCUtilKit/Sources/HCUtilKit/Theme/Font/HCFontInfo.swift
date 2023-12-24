//
//  HCFontInfo.swift
//
//
//  Created by Nemo on 2023/12/21.
//

import SwiftUI

public enum HCFontSizeToken: HCTokenSetKey {
    // See https://gist.github.com/zacwest/916d31da5d03405809c4 for iOS values
    public static let onMac = ProcessInfo.processInfo.isiOSAppOnMac

    case size11
    case size12
    case size13
    case size14
    case size15
    case size16
    case size17
    case size18
    case size20
    case size22
    case size28
    case size34
    case size60

    var value: CGFloat {
        switch self {
        case .size11:
            return 11.0
        case .size12:
            return 12.0
        case .size13:
            return 13.0
        case .size14:
            return 14.0
        case .size15:
            return 15.0
        case .size16:
            return 15.0
        case .size17:
            return 17.0
        case .size18:
            return 18.0
        case .size20:
            return 20.0
        case .size22:
            return 22.0
        case .size28:
            return 28.0
        case .size34:
            return 34.0
        case .size60:
            return 60.0
        }
    }

    /// 支持多平台的value
    var platformValue: CGFloat {
        switch self {
        case .size11:
            return (HCFontSizeToken.onMac ? 12.0 : 11.0)
        case .size12:
            return 12.0
        case .size13:
            return 13.0
        case .size14:
            return 14.0
        case .size15:
            return 15.0
        case .size16:
            return 15.0
        case .size17:
            return 17.0
        case .size18:
            return 18.0
        case .size20:
            return 20.0
        case .size22:
            return 22.0
        case .size28:
            return 28.0
        case .size34:
            return 34.0
        case .size60:
            return 60.0
        }
    }
}

public enum HCFontWeightToken: HCTokenSetKey {
    /// 默认
    case preferred
    /// 以下是Font.Weight
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    var value: Font.Weight? {
        switch self {
        case .preferred:
            return nil
        case .ultraLight:
            return .ultraLight
        case .thin:
            return .thin
        case .light:
            return .light
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        case .bold:
            return .bold
        case .heavy:
            return .heavy
        case .black:
            return .black
        }
    }
    
    func of(_ size: CGFloat) -> Font {
        guard let weightValue = value else {
            return .system(size: size)
        }
        
        return .system(size: size, weight: weightValue)
    }
}

public enum HCFontTextStyleToken: HCTokenSetKey {
    /// The font style for large titles.
    case largeTitle

    /// The font used for first level hierarchical headings.
    case title

    /// The font used for second level hierarchical headings.
    case title2

    /// The font used for third level hierarchical headings.
    case title3

    /// The font used for headings.
    case headline

    /// The font used for subheadings.
    case subheadline

    /// The font used for body text.
    case body

    /// The font used for callouts.
    case callout

    /// The font used in footnotes.
    case footnote

    /// The font used for standard captions.
    case caption

    /// The font used for alternate captions.
    case caption2
    
    var value: Font.TextStyle {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .largeTitle
        case .title2:
            return .largeTitle
        case .title3:
            return .largeTitle
        case .headline:
            return .largeTitle
        case .subheadline:
            return .largeTitle
        case .body:
            return .largeTitle
        case .callout:
            return .largeTitle
        case .footnote:
            return .largeTitle
        case .caption:
            return .largeTitle
        case .caption2:
            return .largeTitle
        }
    }
}


/// Represents the description of a font used by FluentUI components.
public class HCFontInfo {
    
    /// An optional name for the font. If none is provided, defaults to the standard system font.
    public let name: String?

    /// The point size to use for the font.
    private let sizeToken: HCFontSizeToken

    /// 字体真实大小：取决于sizeToken和scale
    public let size: CGFloat

    /// The weight to use for the font.
    public let weight: Font.Weight
    
    public let design: Font.Design

    /// 动态字体
    public let relativeTo: Bool

    /// 是否将字体大小进行缩放
    private let scale: Bool

    /// Creates a `HCFontInfo` instance using the specified information.
    ///
    /// This struct simply stores information about a future font. Fluent will use this information to create the appropriate font object internally as needed.
    ///
    /// - Parameter name: An optional name for the font. If none is provided, defaults to the standard system font.
    /// - Parameter size: The point size to use for the font.
    /// - Parameter weight: The weight to use for the font. Defaults to `.regular`.
    /// - Parameter design: The design to use for the font. Defaults to `.default`.
    /// - Parameter relativeTo: custome font need relativeTo.
    ///
    /// - Returns: A struct containing the information needed to create a font object.
    public init(name: String? = nil,
                sizeToken: HCFontSizeToken,
                scale: Bool = true,
                weight: Font.Weight = .regular,
                design: Font.Design = .default,
                relativeTo: Bool = true) {
        if let newName = name {
            self.name = newName
        } else {
            if let chosenFontName = Theme.shared.chosenFont?.fontName {
                self.name = chosenFontName
            } else {
                self.name = name
            }
        }
        self.sizeToken = sizeToken
        self.scale = scale

        let oriSizeValue = sizeToken.value
        if oriSizeValue > 0 {
            var needScaleSize = oriSizeValue
            if scale {
                needScaleSize = HCFontInfo.userScaledFontSize(baseSize: oriSizeValue)
            }
            self.size = needScaleSize
        } else {
            // default
            self.size = HCFontSizeToken.size16.value
        }
        self.weight = weight
        self.design = design
        self.relativeTo = relativeTo
    }
    
    static func userScaledFontSize(baseSize: CGFloat) -> CGFloat {
#if os(macOS)
        return 1.0
#else
        UIFontMetrics.default.scaledValue(for: baseSize * Theme.shared.fontSizeScale)
#endif
    }
    
    var textStyle: Font.TextStyle {
        // Defaults to smallest supported text style for mapping, before checking if we're bigger.
        var textStyle = Font.TextStyle.caption2
        for tuple in Self.sizeTuples {
            if self.size >= tuple.size {
                textStyle = tuple.textStyle
                break
            }
        }
        return textStyle
    }
    
    fileprivate static var sizeTuples: [(size: CGFloat, textStyle: Font.TextStyle)] = [
        (34.0, .largeTitle),
        (28.0, .title),
        (22.0, .title2),
        (20.0, .title3),
        // Note: `17.0: .headline` is removed to avoid needing duplicate size key values.
        // But it's okay because Apple's scaling curve is identical between it and `.body`.
        (17.0, .body),
        (16.0, .callout),
        (15.0, .subheadline),
        (13.0, .footnote),
        (12.0, .caption),
        (11.0, .caption2)
    ]
}

public extension Font {
    // MARK: - Font Init
    /// 返回一个字体：没有自动缩放
    /// - Parameter fontInfo: 字体信息
    /// - Returns: 字体
    static func info(_ fontInfo: HCFontInfo, scale: Bool = true) -> Font {
        var font: Font
        if let name = fontInfo.name, !name.isEmpty {
            if fontInfo.relativeTo {
                font = .custom(name, size: fontInfo.size, relativeTo: fontInfo.textStyle)
            } else {
                font = .custom(name, fixedSize: fontInfo.size)
            }
        } else {
            font = Font.system(size: fontInfo.size, weight: fontInfo.weight, design: fontInfo.design)
        }
        return font
    }

    init(_ name: String, size: CGFloat, scale: Bool = true) {
        var sizeValue = size;
        if scale {
            sizeValue = HCFontInfo.userScaledFontSize(baseSize: size)
        }
        let font = UIFont(name: name, size: sizeValue) ?? UIFont.systemFont(ofSize: sizeValue)
        self.init(font)
    }

    // MARK: - Font
    private static func customFont(size: CGFloat, relativeTo textStyle: TextStyle) -> Font {
        if let chosenFont = Theme.shared.chosenFont {
            if chosenFont.fontName == ".AppleSystemUIFontRounded-Regular" {
                return .system(size: size, design: .rounded)
            } else {
                return .custom(chosenFont.fontName, size: size, relativeTo: textStyle)
            }
        }

        return .system(size: size, design: .default)
    }
}
