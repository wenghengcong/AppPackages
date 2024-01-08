//
//  Theme+ViewModifier.swift
//  
//
//  Created by Nemo on 2024/1/8.
//

import Foundation
import SwiftUI

public struct ThemeFontViewModifier: ViewModifier {
    @EnvironmentObject private var theme: Theme
    
    var token: Theme.TypographyToken
    
    public func body(content: Content) -> some View {
        content
            .font(theme.typography(token))
    }
}

/// 背景色
public struct ThemeBackColorViewModifier: ViewModifier {
    @EnvironmentObject private var theme: Theme
    
    var token: Theme.ColorToken
    
    public func body(content: Content) -> some View {
        content
            .background(theme.color(token))
    }
}

/// 前景色
public struct ThemeForeColorViewModifier: ViewModifier {
    @EnvironmentObject private var theme: Theme
    
    var token: Theme.ColorToken
    
    public func body(content: Content) -> some View {
        content
            .foregroundColor(theme.color(token))
    }
}

/// 背景色+前景色
public struct ThemeColorViewModifier: ViewModifier {
    @EnvironmentObject private var theme: Theme
    
    var backToken: Theme.ColorToken?
    var foreToken: Theme.ColorToken?
    
    public func body(content: Content) -> some View {
        if backToken != nil && foreToken != nil {
            content
                .background(theme.color(backToken!))
                .foregroundColor(theme.color(foreToken!))
        } else if backToken != nil {
            content
                .background(theme.color(backToken!))
        } else if foreToken != nil {
            content
                .foregroundColor(theme.color(foreToken!))
        }
        
    }
}

public extension View {
    
    /// 字体
    /// - Parameter token: 字体token
    func themeFont(token: Theme.TypographyToken) -> some View {
        modifier(ThemeFontViewModifier(token: token))
    }
    
    /// 前景色
    /// - Parameter token: 颜色token
    func themeForeColor(token: Theme.ColorToken) -> some View {
        modifier(ThemeForeColorViewModifier(token: token))
    }
    
    /// 背景色
    /// - Parameter token: 颜色token
    func themeBackColor(token: Theme.ColorToken = .background) -> some View {
        modifier(ThemeBackColorViewModifier(token: token))
    }
    
    /// 背景+前景色
    /// - Parameters:
    ///   - back: 背景色
    ///   - fore: 前景色
    func themeColor(back:Theme.ColorToken?, fore: Theme.ColorToken?) -> some View {
        modifier(ThemeColorViewModifier(backToken: back, foreToken: fore))
    }
    
    func themeForeTintColor() -> some View {
        modifier(ThemeForeColorViewModifier(token: .tint))
    }
}
