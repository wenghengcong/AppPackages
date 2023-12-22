//
//  HCFontInfo.swift
//
//
//  Created by Nemo on 2023/12/21.
//

import SwiftUI


public enum HCFontSizeToken: HCTokenSetKey {
    case size100
    case size200
    case size300
    case size400
    case size500
    case size600
    case size700
    case size800
    case size900
    
    var value: CGFloat {
        switch self {
        case .size100:
            return 12.0
        case .size200:
            return 13.0
        case .size300:
            return 15.0
        case .size400:
            return 17.0
        case .size500:
            return 20.0
        case .size600:
            return 22.0
        case .size700:
            return 28.0
        case .size800:
            return 34.0
        case .size900:
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
                size: HCFontSizeToken,
                weight: Font.Weight = .regular,
                design: Font.Design = .default,
                relativeTo: Bool = true) {
        self.name = name
        self.size = size
        self.weight = weight
        self.design = design
        self.relativeTo = relativeTo
    }
    
    /// An optional name for the font. If none is provided, defaults to the standard system font.
    public let name: String?
    
    /// The point size to use for the font.
    public let size: HCFontSizeToken
    
    /// The weight to use for the font.
    public let weight: Font.Weight
    
    public let design: Font.Design
    
    /// 在自定义字体时是否缩放
    public let relativeTo: Bool
    
    var textStyle: Font.TextStyle {
        // Defaults to smallest supported text style for mapping, before checking if we're bigger.
        var textStyle = Font.TextStyle.caption2
        for tuple in Self.sizeTuples {
            if self.size.value >= tuple.size {
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
