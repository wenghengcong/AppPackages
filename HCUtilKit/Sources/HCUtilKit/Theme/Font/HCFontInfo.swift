//
//  HCFontInfo.swift
//  
//
//  Created by Nemo on 2023/12/21.
//

import SwiftUI


/**
 Default text sizes taken from Apple's Human Interface Guidelines ([iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/)). These sizes correspond to the default category used by `UIFontMetrics` for dynamic type. It varies per OS and device.
 
  https://developer.apple.com/design/human-interface-guidelines/foundations/typography/
  Large (Default)
  Style          Weight      Size (points)    Leading (points)
  Large Title    Regular      34                 41
  Title 1        Regular      28                 34
  Title 2        Regular      22                 28
  Title 3        Regular      20                 25
  Headline       Semibold     17                 22
  Body           Regular      17                 22
  Callout        Regular      16                 21
  Subhead        Regular      15                 20
  Footnote       Regular      13                 18
  Caption 1      Regular      12                 16
  Caption 2      Regular      11                 13
  
 系统控件各类元素大小分析
 */


#if os(iOS)
import UIKit
@available(iOS 11.0, *)
public let defaultFontSizes: [UIFont.TextStyle: CGFloat] =
    [.caption2: 11,
     .caption1: 12,
     .footnote: 13,
     .subheadline: 15,
     .callout: 16,
     .body: 17,
     .headline: 17,
     .title3: 20,
     .title2: 22,
     .title1: 28,
     .largeTitle: 34]
#endif


/*----tvos----*/
#if os(tvOS)
import UIKit

@available(tvOS 11.0, *)
public let defaultFontSizes: [UIFont.TextStyle: CGFloat] =
    [.caption2: 23,
     .caption1: 25,
     .footnote: 29,
     .subheadline: 29,
     .body: 29,
     .callout: 31,
     .headline: 38,
     .title3: 48,
     .title2: 57,
     .title1: 76]
#endif

/*----watchOS----*/
#if os(watchOS)
import WatchKit

/**
 Default text sizes taken from Apple's Human Interface Guidelines ([iOS](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), [watchOS](https://developer.apple.com/design/human-interface-guidelines/watchos/visual-design/typography/), [tvOS](https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/typography/)). These sizes correspond to the default category used by `UIFontMetrics` for dynamic type. It varies per OS and device.
 */
public let defaultFontSizes: [UIFont.TextStyle: CGFloat] = {
    if #available(watchOS 5.0, *) {
        switch (WKInterfaceDevice.current().preferredContentSizeCategory) {
        case "UICTContentSizeCategoryS":
            return [.footnote: 12,
                    .caption2: 13,
                    .caption1: 14,
                    .body: 15,
                    .headline: 15,
                    .title3: 18,
                    .title2: 26,
                    .title1: 30,
                    .largeTitle: 32]
        case "UICTContentSizeCategoryL":
            return [.footnote: 13,
                    .caption2: 14,
                    .caption1: 15,
                    .body: 16,
                    .headline: 16,
                    .title3: 19,
                    .title2: 27,
                    .title1: 34,
                    .largeTitle: 36]
        case "UICTContentSizeCategoryXL":
            return [.footnote: 14,
                    .caption2: 15,
                    .caption1: 16,
                    .body: 17,
                    .headline: 17,
                    .title3: 20,
                    .title2: 30,
                    .title1: 38,
                    .largeTitle: 40]
        default:
            return [:]
        }
    } else {
        /// No `largeTitle` before watchOS 5
        switch (WKInterfaceDevice.current().preferredContentSizeCategory) {
        case "UICTContentSizeCategoryS":
            return [.footnote: 12,
                    .caption2: 13,
                    .caption1: 14,
                    .body: 15,
                    .headline: 15,
                    .title3: 18,
                    .title2: 26,
                    .title1: 30]
        case "UICTContentSizeCategoryL":
            return [.footnote: 13,
                    .caption2: 14,
                    .caption1: 15,
                    .body: 16,
                    .headline: 16,
                    .title3: 19,
                    .title2: 27,
                    .title1: 34]
        default:
            return [:]
        }
    }
}()
#endif

/// Represents the description of a font used by FluentUI components.
public class HCFontInfo {

    /// Creates a `HCFontInfo` instance using the specified information.
    ///
    /// This struct simply stores information about a future font. Fluent will use this information to create the appropriate font object internally as needed.
    ///
    /// - Parameter name: An optional name for the font. If none is provided, defaults to the standard system font.
    /// - Parameter size: The point size to use for the font.
    /// - Parameter weight: The weight to use for the font. Defaults to `.regular`.
    ///
    /// - Returns: A struct containing the information needed to create a font object.
    public init(name: String? = nil,
                size: CGFloat,
                weight: Font.Weight = .regular) {
        self.name = name
        self.size = size
        self.weight = weight
    }

    /// An optional name for the font. If none is provided, defaults to the standard system font.
    public let name: String?

    /// The point size to use for the font.
    public let size: CGFloat

    /// The weight to use for the font.
    public let weight: Font.Weight

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

// MARK: - ViewModifier

public extension Font {
    
    /// 返回一个字体
    ///  ```
    ///  let font = Font.info(.init(size: 10), shouldScale: true)
    ///  let font2 = Font.info(.init(name: HCBuiltInFont.notoSansMyanmarBold.rawValue, size: 10, weight: .bold))
    ///  ```
    /// - Parameters:
    ///   - fontInfo: 字体信息
    ///   - shouldScale: 是否缩放
    /// - Returns: 字体
    static func info(_ fontInfo: HCFontInfo, 
                     shouldScale: Bool = true) -> Font {
        // SwiftUI Font is missing some of the ease of construction available in UIFont.
        // So just leverage the logic there to create the equivalent SwiftUI font.
        let uiFont = UIFont.info(fontInfo, shouldScale: shouldScale)
        return uiFont
    }
    
    static func info(_ fontInfo: HCFontInfo,
                            shouldScale: Bool = true,
                            contentSizeCategory: UIContentSizeCategory?) -> Font {
        let uiFont = UIFont.info(fontInfo, shouldScale: shouldScale, contentSizeCategory: contentSizeCategory)
        return uiFont
    }
}

extension UIFont {
    static func info(_ fontInfo: HCFontInfo, shouldScale: Bool = true) -> Font {
        return info(fontInfo, shouldScale: shouldScale, contentSizeCategory: nil)
    }

    static func info(_ fontInfo: HCFontInfo, shouldScale: Bool = true, contentSizeCategory: UIContentSizeCategory?) -> Font {
        let traitCollection: UITraitCollection?
        if let contentSizeCategory = contentSizeCategory {
            traitCollection = .init(preferredContentSizeCategory: contentSizeCategory)
        } else {
            traitCollection = nil
        }

        let weight = uiWeight(fontInfo.weight)

        if let name = fontInfo.name,
           let font = UIFont(name: name, size: fontInfo.size) {
            // Named font
            let unscaledFont = font.withWeight(weight)
            if shouldScale {
                let fontMetrics = UIFontMetrics(forTextStyle: uiTextStyle(fontInfo.textStyle))
                let font =  Font( fontMetrics.scaledFont(for: unscaledFont, compatibleWith: traitCollection))
                return font
            } else {
                return Font(unscaledFont)
            }
        } else {
            // System font
            if !shouldScale {
                let sysFont = Font(UIFont.systemFont(ofSize: fontInfo.size, weight: weight))
                return sysFont
            }

            let textStyle = uiTextStyle(fontInfo.textStyle)
            if HCFontInfo.sizeTuples.contains(where: { $0.size == fontInfo.size }) {
                // System-recognized font size, let the OS scale it for us
                let uiFont = UIFont.preferredFont(forTextStyle: textStyle, compatibleWith: traitCollection).withWeight(weight)
                return Font(uiFont)
            }

            // Custom font size, we need to scale it ourselves
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            let uiFont = fontMetrics.scaledFont(for: .systemFont(ofSize: fontInfo.size, weight: weight), compatibleWith: traitCollection)
            return Font(uiFont)
        }
    }

    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        // We need to remove `.name` since it may clash with the requested font weight, but
        // `.family` will ensure that e.g. Helvetica stays Helvetica.
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }

    private static func uiTextStyle(_ textStyle: Font.TextStyle) -> UIFont.TextStyle {
        switch textStyle {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .body:
            return .body
        case .callout:
            return .callout
        case .subheadline:
            return .subheadline
        case .footnote:
            return .footnote
        case .caption:
            return .caption1
        case .caption2:
            return .caption2
        default:
            // Font.TextStyle has `@unknown default` attribute, so we need a default.
            assertionFailure("Unknown Font.TextStyle found! Reverting to .body style.")
            return .body
        }
    }

    private static func uiWeight(_ weight: Font.Weight) -> UIFont.Weight {
        switch weight {
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
        default:
            // Font.Weight has `@unknown default` attribute, so we need a default.
            assertionFailure("Unknown Font.Weight found! Reverting to .regular weight.")
            return .regular
        }
    }
}
