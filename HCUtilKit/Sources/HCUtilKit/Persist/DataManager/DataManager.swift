//
//  BFThemeDataManager.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/8.
//

import Foundation
import CloudKit
import SwiftUI
import CoreData

public struct DataManager {
    public static let shared = DataManager()
    let coreDataStack = CoreDataStack.shared
    /// 删除实体
    /// - Parameter entity: 实体对象
    func delete(_ entity: NSManagedObject) {
        coreDataStack.delete(entity)
    }
}
