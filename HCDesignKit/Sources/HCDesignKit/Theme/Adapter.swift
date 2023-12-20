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


public struct Adapter {
    public static var share = Adapter()
    /// 参考标准（UI是以哪个屏幕设计UI的）
    public var base: Double = 375
    /// 记录适配比例
    public var adapterScale: Double?
}

public protocol Adapterable {
    associatedtype AdapterType
    var adapter: AdapterType { get }
}

extension Adapterable {
    @MainActor func adapterScale() -> Double {
        if let scale = Adapter.share.adapterScale {
            return scale
        } else {
            let width = UIScreen.main.bounds.size.width
            /// 参考标准以 iPhone 6 的宽度为基准
            let referenceWidth: Double = Adapter.share.base
            let scale = width / referenceWidth
            Adapter.share.adapterScale = scale
            return scale
        }
    }
}



extension Int: Adapterable {
    public typealias AdapterType = Int
    @MainActor public var adapter: Int {
        let scale = adapterScale()
        let value = Double(self) * scale
        return Int(value)
    }
}


extension CGFloat: Adapterable {
    public typealias AdapterType = CGFloat
    @MainActor public var adapter: CGFloat {
        let scale = adapterScale()
        let value = self * scale
        return value
    }
}

extension Double: Adapterable {
    public typealias AdapterType = Double
    @MainActor public var adapter: Double {
        let scale = adapterScale()
        let value = self * scale
        return value
    }
}


extension Float: Adapterable {
    public typealias AdapterType = Float
    @MainActor public var adapter: Float {
        let scale = adapterScale()
        let value = self * Float(scale)
        return value
    }
}


extension CGSize: Adapterable {
    public typealias AdapterType = CGSize
    @MainActor public var adapter: CGSize {
        let scale = adapterScale()
        
        let width = self.width * scale
        let height = self.height * scale
        
        return CGSize(width: width, height: height)
    }
}


extension CGRect: Adapterable {
    public typealias AdapterType = CGRect
    @MainActor  public var adapter: CGRect {

        /// 不参与屏幕rect
        if self == UIScreen.main.bounds {
            return self
        }

        let scale = adapterScale()
        let x = origin.x * scale
        let y = origin.y * scale
        let width = size.width * scale
        let height = size.height * scale
        return CGRect(x: x, y: y, width: width, height: height)
    }
}


extension UIFont: Adapterable {
    public typealias AdapterType = UIFont
    @MainActor public var adapter: UIFont {
        let scale = adapterScale()
        let pointSzie = self.pointSize * scale
        let fontDescriptor = self.fontDescriptor
        return UIFont(descriptor: fontDescriptor, size: pointSzie)
    }
}

