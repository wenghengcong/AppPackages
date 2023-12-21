//
//  File.swift
//  
//
//  Created by Nemo on 2023/12/20.
//

import Foundation
import UIKit

/** 要适配的类型
 * Int
 * CGFloat
 * Double
 * Float
 * CGSize
 * CGRect
 * UIFont （保留字体的其他属性，只改变pointSize）
 */
@MainActor
public struct Adapter {
    public static var adapterScale: Double = UIScreen.screenWidth/375.0
}

@MainActor
public protocol Adapterable {
    associatedtype AdapterType
    var adapter: AdapterType { get }
}

public extension Adapterable {
     func adapterScale() -> Double {
        return Adapter.adapterScale
    }
}

extension Int: Adapterable {
    public typealias AdapterType = Int
    public var adapter: Int {
        let value = Double(self) * adapterScale()
        return Int(value)
    }
}

extension CGFloat: Adapterable {
    public typealias AdapterType = CGFloat
    public var adapter: CGFloat {
        let value = self * adapterScale()
        return value
    }
}

extension Double: Adapterable {
    public typealias AdapterType = Double
    public var adapter: Double {
        let value = self * adapterScale()
        return value
    }
}


extension Float: Adapterable {
    public typealias AdapterType = Float
    public var adapter: Float {
        let value = self * Float(adapterScale())
        return value
    }
}


extension CGSize: Adapterable {
    public typealias AdapterType = CGSize
    public var adapter: CGSize {
        let width = self.width * adapterScale()
        let height = self.height * adapterScale()
        return CGSize(width: width, height: height)
    }
}


extension CGRect: Adapterable {
    public typealias AdapterType = CGRect
    public var adapter: CGRect {
        /// 不参与屏幕rect
        if self == UIScreen.main.bounds {
            return self
        }
        let x = origin.x * adapterScale()
        let y = origin.y * adapterScale()
        let width = size.width * adapterScale()
        let height = size.height * adapterScale()
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

extension UIFont: Adapterable {
    public typealias AdapterType = UIFont
    public var adapter: UIFont {
        let pointSzie = self.pointSize * adapterScale()
        let fontDescriptor = self.fontDescriptor
        return UIFont(descriptor: fontDescriptor, size: pointSzie)
    }
}

