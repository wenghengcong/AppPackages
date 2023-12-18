//
//  File.swift
//
//
//  Created by Nemo on 2023/10/25.
//

import Foundation
import SwiftUI

public extension Color {

    init(hex value: Any) {
        self.init(hex: value, alpha: 1.0)
    }

    init(hex value: Any, alpha: Double = 1.0) {
        switch value {
        case let hexString as String:
            self.init(hexString: hexString, alpha:  alpha)
        case let hexInt as Int:
            self.init(hexInt: hexInt, alpha: alpha)
        default:
            fatalError("Invalid color value. Please provide a valid hex string or hex integer.")
        }
    }

    init(rgb:(r: Double, g: Double, b: Double)) {
        self.init(r: rgb.r, g: rgb.g, b: rgb.b, alpha: 1.0)
    }

    init(rgba:(r: Double, g: Double, b: Double, alpha: Double)) {
        self.init(r: rgba.r, g: rgba.g, b: rgba.b, alpha: rgba.alpha)
    }

    init(r: Double, g: Double, b: Double, alpha: Double = 1.0) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue)
    }
    /**
     Create a color with an integer hex, e.g. `0xabcdef`.

     - Parameters:
       - hex: The hex value to apply.
       - alpha: The alpha value to apply, from 0 to 1.
     */
    init(hexInt: Int, alpha: Double = 1.0) {
        self.init(hexInt: hexInt, opacity: alpha)
    }

    init(hexInt: Int, opacity: Double) {
        let red = Double((hexInt & 0xff0000) >> 16) / 255.0
        let green = Double((hexInt & 0xff00) >> 8) / 255.0
        let blue = Double((hexInt & 0xff) >> 0) / 255.0
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
    init(hexString: String, alpha: CGFloat = 1) {
        self.init(hexString: hexString)
    }

    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
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
                Color(hex: "0xabcdef")
                Color(hex: "#abcdef", alpha: 0)
                Color(hex: "#abcdef", alpha: 0.5)
                Color(hex: "#abcdef", alpha: 1)
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
