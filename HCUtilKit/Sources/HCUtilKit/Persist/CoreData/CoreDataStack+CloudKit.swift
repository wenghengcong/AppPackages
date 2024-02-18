//
//  Persistence+CloudKit.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/29.
//

import Foundation
import CoreData
import CloudKit

public extension CoreDataStack {
    /// 获取托管对象记录对应的 CKRecord 的最后修改用户
    func getLastUserID(_ object: NSManagedObject?) -> CKRecord.ID? {
        guard let item = object else {return nil}
        guard let ckRecord = container.record(for: item.objectID) else {return nil}
        guard let userID = ckRecord.lastModifiedUserRecordID else {
            print("can't get userID")
            return nil
        }
        return userID
    }
}
