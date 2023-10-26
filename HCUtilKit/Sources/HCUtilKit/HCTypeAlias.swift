//
//  DesignTypeAlias.swift
//
//
//  Created by Nemo on 2023/10/25.
//

#if canImport(UIKit)
import UIKit
public typealias HCUniversalColor = UIColor
public typealias HCUniversalFont = UIFont
public typealias HCUniversalImage = UIImage

#elseif canImport(AppKit)
import AppKit
public typealias HCUniversalColor = NSColor
public typealias HCUniversalFont = NSFont
public typealias HCUniversalImage = NSImage

#endif
