//
//  File.swift
//
//
//  Created by Nemo on 2023/10/25.
//

import Foundation
import SwiftUI

public extension Color {

    /**
     Create a color with an integer hex, e.g. `0xabcdef`.

     - Parameters:
       - hex: The hex value to apply.
       - alpha: The alpha value to apply, from 0 to 1.
     */
    init(hex: Int, alpha: Double = 1) {
        let opacity = 1.0-alpha
        self.init(hex: hex, opacity: alpha)
    }

    init(hex: Int, opacity: Double) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    /**
     Create a color with a string hex, e.g. `#abcdef`,

     This initializer supports multiple string formats, like
     `abcdef`, `#abcdef`, `0xabcdef`, `#abcdef`.

     - Parameters:
       - hex: The hex string to parse.
       - alpha: The alpha value to apply, from 0 to 1.
     */
    init(hexStr: String, alpha: CGFloat = 1) {
        self.init(hexStr: hexStr)
    }

    init(hexStr: String) {
        var hexSanitized = hexStr.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0
        var opacity: Double = 1.0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
            return
        }
        let length = hexSanitized.count
        if length == 6 {
            red = Double((rgb & 0xFF0000) >> 16) / 255.0
            green = Double((rgb & 0x00FF00) >> 8) / 255.0
            blue = Double(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            red = Double((rgb & 0xFF000000) >> 24) / 255.0
            green = Double((rgb & 0x00FF0000) >> 16) / 255.0
            blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
            opacity = Double(rgb & 0x000000FF) / 255.0
        }
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}


extension Color: RawRepresentable {
    public init?(rawValue: Int) {
        let red = Double((rawValue & 0xFF0000) >> 16) / 0xFF
        let green = Double((rawValue & 0x00FF00) >> 8) / 0xFF
        let blue = Double(rawValue & 0x0000FF) / 0xFF
        self = Color(red: red, green: green, blue: blue)
    }

    public var rawValue: Int {
        guard let coreImageColor else {
            return 0
        }
        let red = Int(coreImageColor.red * 255 + 0.5)
        let green = Int(coreImageColor.green * 255 + 0.5)
        let blue = Int(coreImageColor.blue * 255 + 0.5)
        return (red << 16) | (green << 8) | blue
    }

    private var coreImageColor: CIColor? {
        CIColor(color: .init(self))
    }
}

#Preview {

    struct Preview: View {

        @State private var font = ""

        var body: some View {
            VStack {
                Color(hexStr: "0xabcdef")
                Color(hexStr: "#abcdef", alpha: 0)
                Color(hexStr: "#abcdef", alpha: 0.5)
                Color(hexStr: "#abcdef", alpha: 1)
                Color(hex: 0x000000).frame(height: 10)
                Color(hex: 0xffffff).frame(height: 10)
                Color(hex: 0xabcdef)
                Color(hex: 0xabcdef, alpha: 0)
                Color(hex: 0xabcdef, alpha: 0.5)
                Color(hex: 0xabcdef, alpha: 1)
            }.padding()
        }
    }

    return Preview()
}
