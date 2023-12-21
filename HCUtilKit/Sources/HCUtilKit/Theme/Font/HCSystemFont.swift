//
//  HCSystemFont.swift
//
//
//  Created by Nemo on 2023/12/21.
//

import Foundation
import SwiftUI

/**
 * 获取系统字体的封装类
 
 * Usage:
 ```
 label1.font = HCSystemFont.light.of(size: 17)
 
 label2.font = HCSystemFont.preferred.of(textStyle: .body)
 label2.adjustsFontForContentSizeCategory = true
 
 label3.font = HCSystemFont.semiboldItalic.of(textStyle: .body, maxSize: 30)
 ```
 
 - Important: adjustsFontForContentSizeCategory only works with SystemFont for the preferred weight with a nil maxSize value.
 
 In any other case, you will need to update the font either in traitCollectionDidChange(_:) or by observing the UIContentSizeCategoryDidChange notification. This is because the preferred weight directly returns the result of UIFont.preferredFont(forTextStyle:).
 */
public enum HCSystemFont {
    /**
     Represents the "preferred" system font.
     
     For this case, `of(size:)` returns the direct result of `UIFont.systemFont(ofSize:)`. In addition, `of(textStyle:maxSize:)` returns the direct result of `UIFont.preferredFont(forTextStyle:)` when `maxSize` is `nil`. This is the only case which allows for labels and text views to automatically resize if `adjustsFontForContentSizeCategory` is `true`.
     */
    case preferred
    
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    private enum Style {
        case weight(Font.Weight)
    }
    
    private var style: Style? {
        switch self {
        case .preferred: return nil
            
        case .ultraLight: return .weight(.ultraLight)
        case .thin: return .weight(.thin)
        case .light: return .weight(.light)
        case .regular: return .weight(.regular)
        case .medium: return .weight(.medium)
        case .semibold: return .weight(.semibold)
        case .bold: return .weight(.bold)
        case .heavy: return .weight(.heavy)
        case .black: return .weight(.black)
        }
    }
    
    /**
     Creates a system font object of the specified size.
     
     Instead of using this method to get a font, it’s often more appropriate to use `of(textStyle:maxSize:)` because that method respects the user’s selected content size category.
     
     - Parameter size: The text size for the font.
     
     - Returns: A system font object of the specified size.
     */
    public func ofSize(_ size: CGFloat) -> Font {
        guard let style = style else {
            return .system(size: size)
        }
        
        switch style {
        case .weight(let weight):
            return .system(size: size, weight: weight)
        }
    }
}
