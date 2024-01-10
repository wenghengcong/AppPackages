//
//  DateFormatter+Ext 2.swift
//  
//
//  Created by Nemo on 2023/12/27.
//

import Foundation

public extension ISO8601DateFormatter {
    /// iso8601 默认无毫秒，没有设置formatOptions
    static let iso8601: ISO8601DateFormatter = ISO8601DateFormatter()

    /// UTC：不包含毫秒
    /// 格式：2023-12-27T05:50:56Z
    static var utcNoMill: ISO8601DateFormatter = iso8601(millsec: false, china: false)
    
    /// UTC
    /// e.g. 2023-12-27T05:50:56.694Z
    static var utc: ISO8601DateFormatter = iso8601(millsec: true, china: false)

    /// 中国时区的iso8601
    /// e.g. "2023-12-26T15:39:10+08:00"
    static var chinaNoMill: ISO8601DateFormatter = iso8601(millsec: false, china: true)

    /// 中国时区的iso8601
    /// e.g. "2023-12-26T15:39:10.694+08:00"
    static var china: ISO8601DateFormatter = iso8601(millsec: true, china: true)

    /// iso8601标准格式
    /// - Parameters:
    ///   - millsec: 是否含有毫秒时间
    ///   - china: 时区是否设置为中国，true是中国时区，false是UTC
    /// - Returns: "2023-12-26T15:39:10.694+08:00"
    static func iso8601(millsec: Bool = true,
                        china: Bool = false) -> ISO8601DateFormatter {
        let dateFormatter = ISO8601DateFormatter()
        if millsec {
            dateFormatter.formatOptions = [.withInternetDateTime,.withFractionalSeconds, .withTimeZone]
        } else {
            dateFormatter.formatOptions = [.withInternetDateTime, .withTimeZone]
        }
        dateFormatter.timeZone = china ? .Shanghai : .utc
        return dateFormatter
    }
}

// MARK: - Local
public extension DateFormatter {
    
    /// iso8601 没有设置formatOptions
    static let iso8601: ISO8601DateFormatter = .iso8601
    
    /// UTC：不包含毫秒
    /// 格式：2023-12-27T05:50:56Z
    static var utcNoMill: ISO8601DateFormatter = .utcNoMill
    
    /// UTC
    /// e.g. 2023-12-27T05:50:56.694Z
    static var utc: ISO8601DateFormatter = .utc

    /// 中国时区的iso8601
    /// e.g. "2023-12-26T15:39:10+08:00"
    static var chinaNoMill: ISO8601DateFormatter = .chinaNoMill

    /// 中国时区的iso8601
    /// e.g. "2023-12-26T15:39:10.694+08:00"
    static var china: ISO8601DateFormatter = .china
    
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}

// MARK: - Componnents
public extension DateFormatter {
    /// f开头表示格式：_ 后表示格式，如果其中有空格也用_替代
    static var f_yyyyMMdd: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }
    
    /// f开头表示格式：_ 后表示格式，如果其中有空格也用_替代
    static var f_dd: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }
}
