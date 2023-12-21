//
//  File.swift
//  
//
//  Created by Nemo on 2023/12/19.
//

import Foundation
import SwiftUI

/// 关于App布局的常用都在这里处理
@MainActor
public extension CGFloat {
    
    struct Button {
       public static let cornerRadius: CGFloat = 8.0
    }
    
    static let layoutPadding: CGFloat = 20
    static let dividerPadding: CGFloat = 2
    static let statusColumnsSpacing: CGFloat = 8
    static let secondaryColumnWidth: CGFloat = 400
    static let sidebarWidth: CGFloat = 80
    static let pollBarHeight: CGFloat = 30
}
