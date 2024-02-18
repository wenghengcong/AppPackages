//
//  CoreDataKeys.swift
//  Sunshine
//
//  Created by Nemo on 2024/2/19.
//

import Foundation
/// 来源
public enum CD_SOURCE: Int16 {
    /// 自己创建
    case myself
    /// 系统内置
    case system
    /// 用户
    case user
}

public enum CD_KEY: String {

    // MARK: - 通用字段
    // MARK: 用于唯一标识
    /// 唯一标识：对象UUID
    case uuid
    /// 唯一标识：String类型
    case identifier
    /// Cloudkit的唯一标识
    case recordName

    // MARK: 业务描述
    /// 名称
    case name
    /// 颜色
    case color
    /// 排序
    case sort
    /// emoji
    case emoji
    /// 描述
    case desc
    /// 是否是系统
    case system
    /// 来源：0. 自己  1. 系统  2.其他用户
    case source
    /// 关键字：主要用于搜索，将主要的信息都拼接在keyword中用于搜索使用
    case keyword
    /// 键
    case label
    /// 值
    case value

    // MARK: 业务描述
    /// 是否归档
    case archive
    /// 归档时间：时间戳
    case archiveAt
    /// 归档人
    case archiveBy
    /// 是否删除
    case delete
    /// 删除时间：时间戳
    case deleteAt
    /// 删除人
    case deleteBy

    // MARK: 数据库描述
    /// 修改人
    case modifiedBy
    /// 修改日期
    case modifiedAt
    /// 创建人
    case createdBy
    /// 创建日期
    case createdAt
    /// 数据库版本
    case version

    // MARK: - 时间
    /// 日历中的日期：Date对象，以Record系统的日历为准
    case date
    /// 年份：公历
    case year
    /// 月份：公历
    case month
    /// 日期：公历
    case day
    /// 时间戳
    case timestamp
    /// 唯一时间： 格式2023-12-27T05:50:56Z
    case uniqueTime
    /// 时间全部的格式：2023-12-27T05:50:56.694Z
    case fulltime

    case temp


    enum Priority: String {
        /// 重要性
        case important
        /// 紧急性
        case urgent
        /// 四象限
        case quadrant
    }


    enum Recored: String {
        /// 日历的标识符
        case calendar

        /// 当天记事
        case note

        /// 今日心情，使用emoji
        case mood
        /// 类型： 0-日期   1-心情
        case type
    }
}
