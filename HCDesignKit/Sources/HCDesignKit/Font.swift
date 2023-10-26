import HCAppEnv
import HCUtilKit
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
    
    static var scaledTitle: Font {
        customFont(size: userScaledFontSize(baseSize: title), relativeTo: .title)
    }
    
    static var scaledHeadline: Font {
        customFont(size: userScaledFontSize(baseSize: headline), relativeTo: .headline).weight(.semibold)
    }
    
    static var scaledHeadlineFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: headline))
    }
    
    static var scaledBodyFocused: Font {
        customFont(size: userScaledFontSize(baseSize: body + 2), relativeTo: .body)
    }
    
    static var scaledBodyFocusedFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body + 2))
    }
    
    static var scaledBody: Font {
        customFont(size: userScaledFontSize(baseSize: body), relativeTo: .body)
    }
    
    static var scaledBodyFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledBodyUIFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledCallout: Font {
        customFont(size: userScaledFontSize(baseSize: callout), relativeTo: .callout)
    }
    
    static var scaledCalloutFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
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
    
    static var scaledFootnoteFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: footnote))
    }
    
    static var scaledCaption: Font {
        customFont(size: userScaledFontSize(baseSize: caption), relativeTo: .caption)
    }
    
    static var scaledCaptionFont: HCUniversalFont {
        customUIFont(size: userScaledFontSize(baseSize: caption))
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
