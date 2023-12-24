//
//  Noti+Extension.swift
//
//
//  Created by Nemo on 2023/12/20.
//

import Foundation

public extension Notification.Name {
    struct hcBusiness {
        public static let willLogin = Notification.Name(rawValue: "\(nk_nemo_prefix).willlogin")
        public static let didLogin = Notification.Name(rawValue: "\(nk_nemo_prefix).didlogin")

        /// 获取到oauth token
        public static let getOAuthToken = Notification.Name(rawValue: "\(nk_nemo_prefix).gettoken")
        /// 登录后，获取到用户信息
        public static let getUserInfo = Notification.Name(rawValue: "\(nk_nemo_prefix).getuserinfo")

        public static let willLogout = Notification.Name(rawValue: "\(nk_nemo_prefix).willlogout")
        public static let didLogout = Notification.Name(rawValue: "\(nk_nemo_prefix).didlogout")

        public static let didChangeTheme = Notification.Name(rawValue: "\(nk_nemo_prefix).didChangeTheme")
    }
    
    struct hcNetwork {
        /// Network reachablity
        /// 网络不可用
        public static let notReachable = Notification.Name(rawValue: "\(nk_nemo_prefix).NotReachable")
        /// 未知网络
        public static let unknown = Notification.Name(rawValue: "\(nk_nemo_prefix).Unknown")

        /// 网络不可用->可用
        public static let reachableAfterUnreachable = Notification.Name(rawValue: "\(nk_nemo_prefix).ReachableAfterUnreachable")
        /// 网络可用->不可用
        public static let unReachableAfterReachable = Notification.Name(rawValue: "\(nk_nemo_prefix).UnReachableAfterReachable")


        /// Wifi
        public static let reachableWiFi = Notification.Name(rawValue: "\(nk_nemo_prefix).ReachableWiFi")
        /// 蜂窝网络
        public static let reachableCellular = Notification.Name(rawValue: "\(nk_nemo_prefix).ReachableCellular")
        /// 网络变化
        public static let reachabilityChanged = Notification.Name("\(nk_nemo_prefix).ReachabilityChanged")
    }

    struct hcApp {
        public static let enterHome = Notification.Name(rawValue: "\(nk_nemo_prefix).App.EnterHome")
        public static let enterMine = Notification.Name(rawValue: "\(nk_nemo_prefix).App.EnterMine")
    }
    
    struct hcPrivacy {
        public static let privacyDialog = Notification.Name(rawValue: "\(nk_nemo_prefix)Privacy.PrivacyDialog")
        public static let Push = Notification.Name(rawValue: "\(nk_nemo_prefix).Privacy.Push")
    }
    
    struct hcPay {
        public static let resultRefresh = Notification.Name(rawValue: "\(nk_nemo_prefix).Pay.ResultRefresh")
    }
    
    struct hcCoreData {
        public static let didFindRelevantTransactions = Notification.Name("\(nk_nemo_prefix).didFindRelevantTransactions")
    }
}
