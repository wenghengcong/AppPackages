//
//  SettingsIconView.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/11.
//

#if canImport(SwiftUI)
import SwiftUI

var iconFontSize: Int { 16 }
var backgroundFontSize: Int { 32 }
var backgroundSystemName: String { "app.fill" }

@available(iOS 13, tvOS 13, macOS 11, *)
public struct SettingsIcon: View {

    let systemName: String
    let backgroundColor: Color

    public var body: some View {
        ZStack {
            Image(systemName: backgroundSystemName)
                .font(.system(size: CGFloat(backgroundFontSize)))
                .foregroundColor(backgroundColor)
            Image(systemName: systemName)
                .font(.system(size: CGFloat(iconFontSize)))
                .foregroundColor(.white)
        }
    }
}
#endif
