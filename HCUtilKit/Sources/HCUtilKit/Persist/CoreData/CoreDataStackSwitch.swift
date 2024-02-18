//
//  CoreDataStack+Test.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/29.
//

import Foundation
import CoreData

public struct CoreDataStackSwitch {
    // MARK: Configuration Options
    /// 配置均在Scheme中配置
    // testingEnabled - Customize class behaviors for testing
    static var testingEnabled: Bool = {
        let arguments = ProcessInfo.processInfo.arguments
        var enabled = false
        for index in 0..<arguments.count - 1 where arguments[index] == "-CKTesting" {
            enabled = arguments.count >= (index + 1) ? arguments[index + 1] == "1" : false
            break
        }
        return enabled
    }()
    
    
    /// allowCloudKitSync - Enable or disable CloudKit sync
    /// 设置为 0 将关闭网络同步
    static var allowCloudKitSync: Bool = {
        let arguments = ProcessInfo.processInfo.arguments
        var allow = true
        for index in 0..<arguments.count - 1 where arguments[index] == "-allowCloudKitSync" {
            allow = arguments.count >= (index + 1) ? arguments[index + 1] == "1" : true
            break
        }
        return allow
    }()
}
