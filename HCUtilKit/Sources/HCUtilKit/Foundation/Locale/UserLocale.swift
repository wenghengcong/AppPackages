//
//  UserLocale.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/15.
//

import Foundation

public let UserLocaleUnkownIden = "Unkown"

/// 用户本地化
public class UserLocale: ObservableObject {

    public static let shared = UserLocale()
    /// 用户使用的日历
    public var calendar = UserCalendar.shared

    /// 本地信息
    public var locale = Locale.current
    
    /// 返回region identifier
    /// - Returns: 如果没有获取到，返回Unkown
    public var regionId: String  {
        return locale.region?.identifier ?? UserLocaleUnkownIden
    }
    
    /// 返回region identifier，同regionId
    public var regionCode: String  {
        return regionId
    }
    
    /// 获取系统的两位语言代码
    public var languageCode: String {
        return  locale.language.languageCode?.identifier ?? UserLocaleUnkownIden
    }

    /// The current currency.
    public var currencyCode: String {
        return  locale.currency?.identifier ?? UserLocaleUnkownIden
    }

    /// The current currency symbol.
    public var currencySymbol: String {
        return  locale.currencySymbol ?? UserLocaleUnkownIden
    }

    /// Check if the system is using the metric system.
    ///  usesMetricSystem 属性表示当前地区是否使用米制单位系统。
    ///  米制单位系统中长度单位使用米（m），质量使用千克（kg），体积使用升（L），温度使用摄氏度（°C）等。
    ///  如果 usesMetricSystem 的值为 true，表示当前地区使用米制单位系统；
    ///  如果为 false，则表示使用英制单位系统
    public var usesMetricSystem: Bool {
        return  locale.usesMetricSystem
    }

    /// The decimal separator
    public var decimalSeparator: String {
        return locale.decimalSeparator ?? UserLocaleUnkownIden
    }

    /// The current Time Zone as TimeZone object.
    public static var currentTimeZone: TimeZone {
        return TimeZone.current
    }
    
    /// The current Time Zone identifier.
    public static var currentTimeZoneName: String {
        return TimeZone.current.identifier
    }
}

public extension Locale {
    static var user = UserLocale.shared.locale
}
