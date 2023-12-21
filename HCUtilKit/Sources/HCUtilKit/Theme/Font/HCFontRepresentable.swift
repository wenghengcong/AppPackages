//
//  HCFontRepresentable.swift
//  
//
//  Created by Nemo on 2023/12/21.
//

import Foundation
import SwiftUI

public protocol HCFontRepresentable: RawRepresentable {}

public extension HCFontRepresentable where Self.RawValue == String {
    // MARK: - SwiftUI
    
    @available(tvOS 13.0, iOS 13.0, *)
    /// 返回字体
    /// - Parameter size: 字体大小
    /// - Returns: 字体
    func of(_ size: CGFloat) -> Font {
        return .custom(rawValue, size: size)
    }

    @available(tvOS 13.0, iOS 13.0, *)
    /// 返回字体
    /// - Parameter size: 字体大小
    /// - Returns: 字体
    func of(_ size: Double) -> Font {
        return .custom(rawValue, size: CGFloat(size))
    }
    
    func testFont() {
        let font = Font.info(.init(size: 10), shouldScale: true)
        let font2 = Font.info(.init(name: HCBuiltInFont.notoSansMyanmarBold.rawValue, size: 10, weight: .bold))
    }
}
