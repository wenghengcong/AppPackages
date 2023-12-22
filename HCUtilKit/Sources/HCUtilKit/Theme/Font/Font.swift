import SwiftUI

@MainActor
public extension Font {
    // See https://gist.github.com/zacwest/916d31da5d03405809c4 for iOS values
    // Custom values for Mac
    private static let title = 28.0
    private static let headline = onMac ? 20.0 : 17.0
    private static let body = onMac ? 19.0 : 17.0
    private static let callout = onMac ? 17.0 : 16.0
    private static let subheadline = onMac ? 16.0 : 15.0
    private static let footnote = onMac ? 15.0 : 13.0
    private static let caption = onMac ? 14.0 : 12.0
    private static let caption2 = onMac ? 13.0 : 11.0
    private static let onMac = ProcessInfo.processInfo.isiOSAppOnMac
    
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
    
    // MARK: - Font Init

    /// 返回一个字体：没有自动缩放
    /// - Parameter fontInfo: 字体信息
    /// - Returns: 字体
    static func info(_ fontInfo: HCFontInfo, scale: Bool = true) -> Font {
        var size = fontInfo.size.value;
        if scale {
            size = userScaledFontSize(baseSize: size)
        }
        var font: Font
        if let name = fontInfo.name, !name.isEmpty {
            if fontInfo.relativeTo {
                font = .custom(name, size: fontInfo.size.value, relativeTo: fontInfo.textStyle)
            } else {
                font = .custom(name, fixedSize: fontInfo.size.value)
            }
        } else {
            font = Font.system(size: fontInfo.size.value, weight: fontInfo.weight, design: fontInfo.design)
        }
        return font
    }
    
    init(_ name: String, size: CGFloat, scale: Bool = true) {
        var sizeValue = size;
        if scale {
            sizeValue = Font.userScaledFontSize(baseSize: size)
        }
        let font = UIFont(name: name, size: sizeValue) ?? UIFont.systemFont(ofSize: sizeValue)
        self.init(font)
    }
    
    // MARK: - Font
    static var scaledBodyFocused: Font {
        customFont(size: userScaledFontSize(baseSize: body + 2), relativeTo: .body)
    }
    
    static var scaledBody: Font {
        customFont(size: userScaledFontSize(baseSize: body), relativeTo: .body)
    }
    
    static var scaledCallout: Font {
        customFont(size: userScaledFontSize(baseSize: callout), relativeTo: .callout)
    }
    
    static var scaledSubheadline: Font {
        customFont(size: userScaledFontSize(baseSize: subheadline), relativeTo: .subheadline)
    }
    
    static var scaledSubheadlineFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: subheadline))
    }
    
    static var scaledFootnote: Font {
        customFont(size: userScaledFontSize(baseSize: footnote), relativeTo: .footnote)
    }
    
    static var scaledCaption: Font {
        customFont(size: userScaledFontSize(baseSize: caption), relativeTo: .caption)
    }
    
    static var scaledCaption2: Font {
        customFont(size: userScaledFontSize(baseSize: caption2), relativeTo: .caption)
    }
    
    // MARK: - UIFont
    private static func customUIFont(size: CGFloat) -> HCUniversalFont {
        if let chosenFont = Theme.shared.chosenFont {
            return chosenFont.withSize(size)
        }
        return .systemFont(ofSize: size)
    }
    
    private static func userScaledFontSize(baseSize: CGFloat) -> CGFloat {
#if os(macOS)
        return 1.0
#else
        UIFontMetrics.default.scaledValue(for: baseSize * Theme.shared.fontSizeScale)
#endif
    }
    
    static var scaledHeadlineFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: headline))
    }
    
    static var scaledBodyFocusedFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body + 2))
    }
    
    static var scaledBodyFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledBodyUIFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledCalloutFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledTitle: Font {
        customFont(size: userScaledFontSize(baseSize: title), relativeTo: .title)
    }
    
    static var scaledHeadline: Font {
        customFont(size: userScaledFontSize(baseSize: headline), relativeTo: .headline).weight(.semibold)
    }
    
    static var scaledFootnoteFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: footnote))
    }
    
    static var scaledCaptionFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: caption))
    }
    
    static var scaledCaption2Font: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: caption2))
    }
}

public extension HCUniversalFont {
#if os(macOS)
    func rounded() -> NSFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }
        return NSFont(descriptor: descriptor, size: pointSize) ?? NSFont.systemFont(ofSize: pointSize)
    }
#else
    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: pointSize)
    }
#endif
    
    var emojiSize: CGFloat {
        pointSize
    }
    
    var emojiBaselineOffset: CGFloat {
        // Center emoji with capital letter size of font
        -(emojiSize - capHeight) / 2
    }
}
