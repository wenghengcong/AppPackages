//
//  File.swift
//
//
//  Created by Nemo on 2023/10/25.
//

import HCUtilKit
import Foundation
#if canImport(SwiftUI) && canImport(Combine) && (arch(arm64) || arch(x86_64))
// https://stackoverflow.com/a/61954608
import SwiftUI


#if !os(watchOS) // All the methods below are not availalbe for WatchOS at the time of writing
// MARK: - Adaptable colors
// Links to standard colors documentation
// Platform | Reference
// ---------|-----------
// iOS      | https://developer.apple.com/documentation/uikit/uicolor/standard_colors
// macOS      | https://developer.apple.com/documentation/appkit/nscolor/standard_colors
@available(iOS 13.0, macOS 10.15, *)
public extension Color {
    /// A blue color that automatically adapts to the current trait environment.
    static var systemBlue: Color { Color(HCUniversalColor.systemBlue) }
    /// A brown color that automatically adapts to the current trait environment.
    static var systemBrown: Color { Color(HCUniversalColor.systemBrown) }
    /// A cyan color that automatically adapts to the current trait environment.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    static var systemCyan: Color { Color(HCUniversalColor.systemCyan) }
    /// A green color that automatically adapts to the current trait environment.
    static var systemGreen: Color { Color(HCUniversalColor.systemGreen) }
    /// An indigo color that automatically adapts to the current trait environment.
    static var systemIndigo: Color { Color(HCUniversalColor.systemIndigo) }
    /// A mint color that automatically adapts to the current trait environment.
    @available(iOS 15.0, macOS 10.15, tvOS 15.0, *)
    static var systemMint: Color { Color(HCUniversalColor.systemMint) }
    /// An orange color that automatically adapts to the current trait environment.
    static var systemOrange: Color { Color(HCUniversalColor.systemOrange) }
    /// A pink color that automatically adapts to the current trait environment.
    static var systemPink: Color { Color(HCUniversalColor.systemPink) }
    /// A purple color that automatically adapts to the current trait environment.
    static var systemPurple: Color { Color(HCUniversalColor.systemPurple) }
    /// A red color that automatically adapts to the current trait environment.
    static var systemRed: Color { Color(HCUniversalColor.systemRed) }
    /// A teal color that automatically adapts to the current trait environment.
    static var systemTeal: Color { Color(HCUniversalColor.systemTeal) }
    /// A yellow color that automatically adapts to the current trait environment.
    static var systemYellow: Color { Color(HCUniversalColor.systemYellow) }
}

// MARK: - Adaptable Gray Colors
// Links to standard colors documentation
// Platform | Reference
// ---------|-----------
// iOS      | https://developer.apple.com/documentation/uikit/uicolor/standard_colors
// OSX      | https://developer.apple.com/documentation/appkit/nscolor/standard_colors
@available(iOS 13.0, OSX 10.15, *)
public extension Color {
    /// The standard base gray color that adapts to the environment.
    static var systemGray: Color { Color(HCUniversalColor.systemGray) }
}

#if canImport(UIKit) && !os(tvOS)
@available(iOS 13.0, *)
public extension Color {
    /// A second-level shade of gray that adapts to the environment.
    static var systemGray2: Color { Color(HCUniversalColor.systemGray2) }
    /// A third-level shade of gray that adapts to the environment.
    static var systemGray3: Color { Color(HCUniversalColor.systemGray3) }
    /// A fourth-level shade of gray that adapts to the environment.
    static var systemGray4: Color { Color(HCUniversalColor.systemGray4) }
    /// A fifth-level shade of gray that adapts to the environment.
    static var systemGray5: Color { Color(HCUniversalColor.systemGray5) }
    /// A sixth-level shade of gray that adapts to the environment.
    static var systemGray6: Color { Color(HCUniversalColor.systemGray6) }
}
#endif

// MARK: - Fixed Colors
// Links to standard colors documentation
// Platform | Reference
// ---------|-----------
// iOS      | https://developer.apple.com/documentation/uikit/uicolor/standard_colors
// OSX      | https://developer.apple.com/documentation/appkit/nscolor/standard_colors
@available(iOS 13.0, OSX 10.15, *)
public extension Color {
    /// A color object with a grayscale value of 1/3 and an alpha value of 1.0.
    static var darkGray: Color { Color(HCUniversalColor.darkGray) }
    /// A color object with a grayscale value of 2/3 and an alpha value of 1.0.
    static var lightGray: Color { Color(HCUniversalColor.lightGray) }
    /// A color object with RGB values of 1.0, 0.0, and 1.0, and an alpha value of 1.0.
    static var magenta: Color { Color(HCUniversalColor.magenta) }
}

// MARK: - UI Element Colors
// Links to standard colors documentation
// Platform | Reference
// ---------|-----------
// iOS      | https://developer.apple.com/documentation/uikit/uicolor/ui_element_colors
// OSX      | https://developer.apple.com/documentation/appkit/nscolor/ui_element_colors
#if canImport(UIKit)
@available(iOS 13.0, *)
public extension Color {
    // MARK: Label Colors
    /// The color for text labels that contain primary content.
    static var label: Color { Color(HCUniversalColor.label) }
    /// The color for text labels that contain secondary content.
    static var secondaryLabel: Color { Color(HCUniversalColor.secondaryLabel) }
    /// The color for text labels that contain tertiary content.
    static var tertiaryLabel: Color { Color(HCUniversalColor.tertiaryLabel) }
    /// The color for text labels that contain quaternary content.
    static var quaternaryLabel: Color { Color(HCUniversalColor.quaternaryLabel) }
    
    // MARK: Fill Colors
    /// An overlay fill color for thin and small shapes.
    @available(tvOS, unavailable)
    static var systemFill: Color { Color(HCUniversalColor.systemFill) }
    /// An overlay fill color for medium-size shapes.
    @available(tvOS, unavailable)
    static var secondarySystemFill: Color { Color(HCUniversalColor.secondarySystemFill) }
    /// An overlay fill color for large shapes.
    @available(tvOS, unavailable)
    static var tertiarySystemFill: Color { Color(HCUniversalColor.tertiarySystemFill) }
    /// An overlay fill color for large areas that contain complex content.
    @available(tvOS, unavailable)
    static var quaternarySystemFill: Color { Color(HCUniversalColor.quaternarySystemFill) }
    
    // MARK: Text Colors
    /// The color for placeholder text in controls or text views.
    static var placeholderText: Color { Color(HCUniversalColor.placeholderText) }
    
    // MARK: Standard Content Background Colors
    /// Use these colors for standard table views and designs that have a white primary background in a light environment.
    
    /// The color for the main background of your interface.
    @available(tvOS, unavailable)
    static var systemBackground: Color { Color(HCUniversalColor.systemBackground) }
    /// The color for content layered on top of the main background.
    @available(tvOS, unavailable)
    static var secondarySystemBackground: Color { Color(HCUniversalColor.secondarySystemBackground) }
    /// The color for content layered on top of secondary backgrounds.
    @available(tvOS, unavailable)
    static var tertiarySystemBackground: Color { Color(HCUniversalColor.tertiarySystemBackground) }
    
    // MARK: Grouped Content Background Colors
    /// Use these colors for grouped content, including table views and platter-based designs.
    
    /// The color for the main background of your grouped interface.
    @available(tvOS, unavailable)
    static var systemGroupedBackground: Color { Color(HCUniversalColor.systemGroupedBackground) }
    /// The color for content layered on top of the main background of your grouped interface.
    @available(tvOS, unavailable)
    static var secondarySystemGroupedBackground: Color { Color(HCUniversalColor.secondarySystemGroupedBackground) }
    /// The color for content layered on top of secondary backgrounds of your grouped interface.
    @available(tvOS, unavailable)
    static var tertiarySystemGroupedBackground: Color { Color(HCUniversalColor.tertiarySystemGroupedBackground) }
    
    // MARK: Separator Colors
    /// The color for thin borders or divider lines that allows some underlying content to be visible.
    static var separator: Color { Color(HCUniversalColor.separator) }
    /// The color for borders or divider lines that hides any underlying content.
    static var opaqueSeparator: Color { Color(HCUniversalColor.opaqueSeparator) }
    
    // MARK: Link Color
    /// The specified color for links.
    static var link: Color { Color(HCUniversalColor.link) }
    
    // MARK: Nonadaptable Colors
    /// The nonadaptable system color for text on a light background.
    @available(tvOS, unavailable)
    static var darkText: Color { Color(HCUniversalColor.darkText) }
    /// The nonadaptable system color for text on a dark background.
    @available(tvOS, unavailable)
    static var lightText: Color { Color(HCUniversalColor.lightText) }
}
#elseif canImport(AppKit)


@available(OSX 10.15, *)
public extension Color {
    // MARK: Label Colors
    /// The primary color to use for text labels.
    static var label: Color { Color(HCUniversalColor.labelColor) }
    /// The secondary color to use for text labels.
    static var secondaryLabel: Color { Color(HCUniversalColor.secondaryLabelColor) }
    /// The tertiary color to use for text labels.
    static var tertiaryLabel: Color { Color(HCUniversalColor.tertiaryLabelColor) }
    /// The quaternary color to use for text labels and separators.
    static var quaternaryLabel: Color { Color(HCUniversalColor.quaternaryLabelColor) }
    
    // MARK: Text Colors
    /// The color to use for text.
    static var text: Color { Color(HCUniversalColor.textColor) }
    /// The color to use for placeholder text in controls or text views.
    static var placeholderText: Color { Color(HCUniversalColor.placeholderTextColor) }
    /// The color to use for selected text.
    static var selectedText: Color { Color(HCUniversalColor.selectedTextColor) }
    /// The color to use for the background area behind text.
    static var textBackground: Color { Color(HCUniversalColor.textBackgroundColor) }
    /// The color to use for the background of selected text.
    static var selectedTextBackground: Color { Color(HCUniversalColor.selectedTextBackgroundColor) }
    /// The color to use for the keyboard focus ring around controls.
    static var keyboardFocusIndicator: Color { Color(HCUniversalColor.keyboardFocusIndicatorColor) }
    /// The color to use for selected text in an unemphasized context.
    static var unemphasizedSelectedText: Color { Color(HCUniversalColor.unemphasizedSelectedTextColor) }
    /// The color to use for the text background in an unemphasized context.
    static var unemphasizedSelectedTextBackground: Color { Color(HCUniversalColor.unemphasizedSelectedTextBackgroundColor) }
    
    // MARK: Content Colors
    /// The color to use for links.
    static var link: Color { Color(HCUniversalColor.linkColor) }
    /// The color to use for separators between different sections of content.
    static var separator: Color { Color(HCUniversalColor.separatorColor) }
    /// The color to use for the background of selected and emphasized content.
    static var selectedContentBackground: Color { Color(HCUniversalColor.selectedContentBackgroundColor) }
    /// The color to use for selected and unemphasized content.
    static var unemphasizedSelectedContentBackground: Color { Color(HCUniversalColor.unemphasizedSelectedContentBackgroundColor) }
    
    // MARK: Menu Colors
    /// The color to use for the text in menu items.
    static var selectedMenuItemText: Color { Color(HCUniversalColor.selectedMenuItemTextColor) }
    
    // MARK: Table Colors
    /// The color to use for the optional gridlines, such as those in a table view.
    static var grid: Color { Color(HCUniversalColor.gridColor) }
    /// The color to use for text in header cells in table views and outline views.
    static var headerText: Color { Color(HCUniversalColor.headerTextColor) }
    /// The colors to use for alternating content, typically found in table views and collection views.
    static var alternatingContentBackgroundColors: [Color] { HCUniversalColor.alternatingContentBackgroundColors.map(Color.init) }
    
    // MARK: Control Colors
    /// The user's current accent color preference.
    static var controlAccent: Color { Color(HCUniversalColor.controlAccentColor) }
    /// The color to use for the flat surfaces of a control.
    static var control: Color { Color(HCUniversalColor.controlColor) }
    /// The color to use for the background of large controls, such as scroll views or table views.
    static var controlBackground: Color { Color(HCUniversalColor.controlBackgroundColor) }
    /// The color to use for text on enabled controls.
    static var controlText: Color { Color(HCUniversalColor.controlTextColor) }
    /// The color to use for text on disabled controls.
    static var disabledControlText: Color { Color(HCUniversalColor.disabledControlTextColor) }
    /// The color to use for the face of a selected control—that is, a control that has been clicked or is being dragged.
    static var selectedControl: Color { Color(HCUniversalColor.selectedControlColor) }
    /// The color to use for text in a selected control—that is, a control being clicked or dragged.
    static var selectedControlText: Color { Color(HCUniversalColor.selectedControlTextColor) }
    /// The color to use for text in a selected control.
    static var alternateSelectedControlText: Color { Color(HCUniversalColor.alternateSelectedControlTextColor) }
    /// The patterned color to use for the background of a scrubber control.
    static var scrubberTexturedBackground: Color { Color(HCUniversalColor.scrubberTexturedBackground) }
    
    // MARK: Window Colors
    /// The color to use for the window background.
    static var windowBackground: Color { Color(HCUniversalColor.windowBackgroundColor) }
    /// The color to use for text in a window's frame.
    static var windowFrameText: Color { Color(HCUniversalColor.windowFrameTextColor) }
    /// The color to use in the area beneath your window's views.
    static var underPageBackground: Color { Color(HCUniversalColor.underPageBackgroundColor) }
    
    // MARK: Highlights and Shadows
    /// The highlight color to use for the bubble that shows inline search result values.
    static var findHighlight: Color { Color(HCUniversalColor.findHighlightColor) }
    /// The color to use as a virtual light source on the screen.
    static var highlight: Color { Color(HCUniversalColor.highlightColor) }
    /// The color to use for virtual shadows cast by raised objects on the screen.
    static var shadow: Color { Color(HCUniversalColor.shadowColor) }
}

#endif // UIKit / AppKit condition
#endif // WatchOS condition
#endif // SwiftUI availability condition


