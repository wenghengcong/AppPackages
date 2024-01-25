//
//  DateExt.swift
//  Sunshine
//
//  Created by Nemo on 2023/10/27.
//

import Foundation
import SwiftDate

/// 特殊日期
public extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

/*
 let dateTest = Date()
 let p1 = dateTest.utcNoMill
 let p2 = dateTest.utc
 let p3 = dateTest.chinaNoMill
 let p4 = dateTest.china

 print(p1)
 print(p2)
 print(p3)
 print(p4)

 let d1 = Date(iso: p1)
 let d2 = Date(iso: p2)
 let d3 = Date(iso: p3)
 let d4 = Date(iso: p4)

 print(d1)
 print(d2)
 print(d3)
 print(d4)
 */
// MARK: - Init
public extension Date {
    /// 以UTC时区新建Date
    /// - Parameter utcString: 格式：2023-12-27T05:50:56Z
    init?(iso: String, timeZone: String = "UTC") {
        
        let timeZone = TimeZone(identifier: timeZone)
        let utcFomatter = DateFormatter.utc
        let utcNoMillFomatter = DateFormatter.utc
        utcFomatter.timeZone = timeZone
        utcNoMillFomatter.timeZone = timeZone
        
        var parseDate: Date? = nil
        if let date = utcFomatter.date(from: iso) {
            parseDate = date
        } else {
            if let date = utcNoMillFomatter.date(from: iso) {
                parseDate = date
            }
        }
        if let date = parseDate {
            self = date
        } else {
            return nil
        }
    }
    
    /// 从yyyyMMdd格式中生成日期
    /// - Parameter dateString: 日期字符串，格式：yyyyMMdd
    init?(yyyyMMdd dateString: String) {
        if let date = Date.getDate(yyyyMMdd: dateString) {
            self = date
        } else {
            return nil
        }
    }
}

// MARK: - Get Date
public extension Date {
    /// 返回ISO8601标准格式的字符串
    /// - Returns: "2023-12-26T15:39:10.694+08:00"
    func iso(mill: Bool = true, china: Bool = false) -> String {
        var isoDateFormmater: ISO8601DateFormatter
        if(china) {
            isoDateFormmater = mill ? .china : .chinaNoMill
        } else {
            isoDateFormmater = mill ? .utc : .utcNoMill
        }
        let dateStr: String = isoDateFormmater.string(from: self)
        return dateStr
    }
    
    /// 从yyyyMMdd格式中生成日期
    /// - Parameter dateString: 日期字符串，格式：yyyyMMdd
    /// - Returns: 日期
    static func getDate(yyyyMMdd dateString: String) -> Date? {
        let formatter = DateFormatter.f_yyyyMMdd
        return formatter.date(from: dateString)
    }

    
    /// 从dd格式中生成日期
    /// - Parameter dateString: 日期字符串，格式：dd
    /// - Returns: 日期
    static func getDay(dd dateString: String) -> Date? {
        let formatter = DateFormatter.f_dd
        return formatter.date(from: dateString)
    }
}

// MARK: - String
public extension Date {
    
    // MARK: Components


    var mediumString: String? {
        return self.toString(.date(.medium))
    }

    /// 获取日期-天
    var ddDay: String {
        let formatter = DateFormatter.f_dd
        return formatter.string(from: self)
    }
    
    // MARK: Local
    /// utc时区 格式的字符串
    /// 格式：2023-12-27T05:50:56Z
    var utcNoMill: String {
        return DateFormatter.utcNoMill.string(from: self)
    }
    
    /// utc时区 格式的字符串
    /// 格式：2023-12-27T05:50:56.694Z
    var utc: String {
        return DateFormatter.utc.string(from: self)
    }
    
    /// 中国时区无毫秒
    /// 格式：2023-12-27T05:50:56Z
    var chinaNoMill: String {
        return DateFormatter.chinaNoMill.string(from: self)
    }
    
    /// 中国时区有毫秒
    /// 格式：2023-12-27T05:50:56.694Z
    var china: String {
        return DateFormatter.china.string(from: self)
    }
    
    /// 获取对应的字符串
    /// - Parameter format: 对应的格式
    /// - Returns: 字符串
    func string(format: DateFormatter) -> String? {
        let str = format.string(from: self)
        return str
    }
}
