//
//  CommonConstant.swift
//
//
//  Created by Nemo on 2023/12/20.
//

import Foundation
import UIKit

enum AppLanguage: String {
    case en = "en"
    case cn = "zh-Hans"
}

enum PlistError: Error {
    case `nil`(String)
    case nsData(String)
    case json(String)
}
