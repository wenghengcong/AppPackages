//
//  AppConfig.swift
//  Mirror
//
//  Created by Nemo on 2023/4/19.
//

import Foundation
import SwiftUI

public struct AppConfig {
    public static var current: AppConfig = AppConfig()

    // MARK: - 具体
    public var ckContainerID: String! = ""
    public var ckContainerFile: String! = ""

    public var groupID: String! = ""
    public var iOSBundleID: String! = ""
    public var appStoreAppId: String! = ""
    public var clientName: String! = ""
    public var scheme: String! = ""
    public var scopes: String! = ""
    public var weblink: String! = ""
    public var revenueCatKey: String! = ""
    public var keychainGroup: String! = ""
    public init() {

    }
}

// MARK: - 应用名
public  extension AppConfig {

    ///  Application name (if applicable).
    static  var displayName: String? {
        return NKDevice.Application.displayName
    }

    /// bundle name
    static  var bundleName: String? {
        return NKDevice.Application.bundleName
    }
}

// MARK: - 版本
public extension AppConfig {
    static var version: String {
        let ver = NKDevice.Application.version
        return ver
    }

    /// The build number.
    static var buildNumber: String {
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "10"
        return build
    }


    /// The complete app version with build number (i.e. : "2.1.3 (343)").
    static var completeAppVersion: String {
        return NKDevice.Application.completeAppVersion
    }
}
