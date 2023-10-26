//
//  DesignTypeAlias.swift
//
//
//  Created by Nemo on 2023/10/25.
//


#if canImport(UIKit)
import UIKit
public typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias PlatformColor = NSColor
#endif
