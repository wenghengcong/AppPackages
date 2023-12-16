//
//  File.swift
//  
//
//  Created by Nemo on 2023/12/16.
//

import SwiftUI

public extension Image {
    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}
