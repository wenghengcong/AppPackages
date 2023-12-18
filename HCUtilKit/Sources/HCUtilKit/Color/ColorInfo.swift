//
//  ColorInfo.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/8.
//

import Foundation
import SwiftUI

public enum ColorSpace: String {
    case sRGB
    case HSB
    case CMYK
}

public struct ColorInfo {
    /// 颜色空间： 如果你在不同的颜色空间之间进行操作，可以存储当前颜色的颜色空间信息
    var colorSpace: ColorSpace
    
    /// Red、Green、Blue 值： RGB 值是颜色的基本构成元素，它们表示红、绿、蓝三个通道的颜色强度。
    var red: Double
    var green: Double
    var blue: Double
    
    /// Hue、Saturation、Brightness（色调、饱和度、明度）： 这些属性用于描述颜色在色轮上的位置、颜色的鲜艳程度以及颜色的亮度。
    var hue: Double
    var saturation: Double
    var brightness: Double
    
    /// CMYK 值： 如果你需要打印颜色，你可能会考虑使用 CMYK（青、品红、黄、黑） 颜色模式。
    var cyan: Double
    var magenta: Double
    var yellow: Double
    var black: Double
    
    /// Alpha 通道（透明度）： 表示颜色的透明度，0 表示完全透明，1 表示完全不透明。
    var alpha: Double
    
    init(colorSpace: ColorSpace,
         red: Double, green: Double, blue: Double,
         hue: Double, saturation: Double, brightness: Double,
         cyan: Double, magenta: Double, yellow: Double, black: Double, alpha: Double) {
        self.colorSpace = colorSpace
        self.red = red
        self.green = green
        self.blue = blue
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.cyan = cyan
        self.magenta = magenta
        self.yellow = yellow
        self.black = black
        self.alpha = alpha
    }
    
    init(from string: String) {
        let propertyPairs = string.components(separatedBy: "_")
        var colorInfoDict: [String: Any] = [:]
        
        for pair in propertyPairs {
            let components = pair.components(separatedBy: ":")
            if components.count == 2, let value = Double(components[1]) {
                colorInfoDict[components[0]] = value
            }
        }
        
        let sapce = ColorSpace(rawValue: (colorInfoDict["colorSpace"] as? String) ?? "sRGB")
        
        self.colorSpace = sapce ?? .sRGB
        self.red = (colorInfoDict["red"] as? Double) ?? 0
        self.green = (colorInfoDict["green"] as? Double) ?? 0
        self.blue = (colorInfoDict["blue"] as? Double) ?? 0
        self.hue = (colorInfoDict["hue"] as? Double) ?? 0
        self.saturation = (colorInfoDict["saturation"] as? Double) ?? 0
        self.brightness = (colorInfoDict["brightness"] as? Double) ?? 0
        self.cyan = (colorInfoDict["cyan"] as? Double) ?? 0
        self.magenta = (colorInfoDict["magenta"] as? Double) ?? 0
        self.yellow = (colorInfoDict["yellow"] as? Double) ?? 0
        self.black = (colorInfoDict["black"] as? Double) ?? 0
        self.alpha = (colorInfoDict["alpha"] as? Double) ?? 1
    }
    
    /// 转换成字符串
    func stringify() -> String {
        let properties = Mirror(reflecting: self).children
        var result = ""
        
        for (label, value) in properties {
            if let label = label {
                result += "\(label):\(value)_"
            }
        }
        
        // Remove the trailing underscore
        if result.hasSuffix("_") {
            result.removeLast()
        }
        
        return result
    }
    
    /// 从ColorInfo的字符串分解颜色信息
    static func parse(from string: String) -> ColorInfo? {
        guard string.isEmpty else {
            return nil
        }
        let propertyPairs = string.components(separatedBy: "_")
        var colorInfoDict: [String: Any] = [:]
        
        for pair in propertyPairs {
            let components = pair.components(separatedBy: ":")
            if components.count == 2, let value = Double(components[1]) {
                colorInfoDict[components[0]] = value
            }
        }
        
        let sapce = ColorSpace(rawValue: (colorInfoDict["colorSpace"] as? String) ?? "sRGB")
        // Create ColorInfo object using the dictionary
        return ColorInfo(
            colorSpace: sapce ?? .sRGB,
            red: (colorInfoDict["red"] as? Double) ?? 0 ,
            green: (colorInfoDict["green"] as? Double) ?? 0,
            blue: (colorInfoDict["blue"] as? Double) ?? 0,
            hue: (colorInfoDict["hue"] as? Double) ?? 0,
            saturation: (colorInfoDict["saturation"] as? Double) ?? 0,
            brightness: (colorInfoDict["brightness"] as? Double) ?? 0,
            cyan: (colorInfoDict["cyan"] as? Double) ?? 0,
            magenta: (colorInfoDict["magenta"] as? Double) ?? 0,
            yellow: (colorInfoDict["yellow"] as? Double) ?? 0,
            black: (colorInfoDict["black"] as? Double) ?? 0,
            alpha: (colorInfoDict["alpha"] as? Double) ?? 1
        )
    }
}


public extension Color {
    
    /// 通过 ColorInfo 字符串创建 Color 对象
    init?(colorInfoString: String?) {
        guard let infoStr = colorInfoString else {
            self.init(red: 0, green: 0, blue: 0, opacity: 1)
            return
        }
        let colorInfo = ColorInfo.init(from: infoStr)
#if canImport(UIKit)
        self.init(red: colorInfo.red, green: colorInfo.green, blue: colorInfo.blue, opacity: colorInfo.alpha)
#elseif canImport(AppKit)
        self.init(
            .sRGB,
            red: colorInfo.red, green: colorInfo.green, blue: colorInfo.blue,
            opacity: colorInfo.alpha
        )
#endif
    }
    
    func toColorInfoString() -> String {
        let colorInfo = toColorInfo()
        let string = colorInfo.stringify()
        return string
    }
    
    /// Color 转 ColorInfo
    /// 注意，ColorInfo 的 CMYK 颜色属性在这里被设置为零，因为 SwiftUI 的 Color 类型不直接提供 CMYK 颜色信息。
    func toColorInfo() -> ColorInfo {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var opacity: CGFloat = 1.0
        
#if canImport(UIKit)
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
#elseif canImport(AppKit)
        NSColor(self).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
#endif
        
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return ColorInfo(
            colorSpace: .sRGB,
            red: Double(red),
            green: Double(green),
            blue: Double(blue),
            hue: Double(hue),
            saturation: Double(saturation),
            brightness: Double(brightness),
            cyan: 0,
            magenta: 0,
            yellow: 0,
            black: 0,
            alpha: Double(alpha)
        )
    }
}
