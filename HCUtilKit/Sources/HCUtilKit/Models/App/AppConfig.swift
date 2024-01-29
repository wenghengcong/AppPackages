//
//  AppConfig.swift
//  Mirror
//
//  Created by Nemo on 2023/4/19.
//

import Foundation
import SwiftUI

public struct AppConfig {

    public static let ckContainerID = "iCloud.com.chuang.nemo.mirror"
    public static let groupID = "group.com.chuang.nemo.mirror"
    public static let iOSBundleID = "com.chuang.nemo.chu.day"

    public static let appStoreAppId = "6444915884"
    public static let clientName = "IceCubesApp"
    public static let scheme = "icecubesapp://"
    public static let scopes = "read write follow push"
    public static let weblink = "https://github.com/Dimillian/IceCubesApp"
    public static let revenueCatKey = "appl_JXmiRckOzXXTsHKitQiicXCvMQi"
    public static let keychainGroup = "346J38YKE3.com.thomasricouard.IceCubesApp"
}

// MARK: - 应用名
public  extension AppConfig {

    ///  Application name (if applicable).
    public static  var displayName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    /// bundle name
    public static  var bundleName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}

// MARK: - 版本
public extension AppConfig {
    public static var version: String {
        let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        return ver
    }

    /// The build number.
    public static var buildNumber: String {
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "10"
        return build
    }


    /// The complete app version with build number (i.e. : "2.1.3 (343)").
    public static var completeAppVersion: String {
        return "\(AppConfig.version) (\(AppConfig.buildNumber))"
    }
}
