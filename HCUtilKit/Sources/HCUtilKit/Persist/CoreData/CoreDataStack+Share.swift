//
//  CoreDataStack+Share.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/6.
//

import SwiftUI
import CoreData
import CloudKit

public extension CoreDataStack {
    func isShared(objectID: NSManagedObjectID) -> Bool {
        var isShared = false
        if let persistentStore = objectID.persistentStore {
            if persistentStore == sharedPersistentStore {
                isShared = true
            } else {
                do {
                    let shares = try container.fetchShares(matching: [objectID])
                    if shares.first != nil {
                        isShared = true
                    }
                } catch {
                    print("Failed to fetch share for \(objectID): \(error)")
                }
            }
        }
        return isShared
    }

    func isShared(object: NSManagedObject) -> Bool {
        isShared(objectID: object.objectID)
    }

    func canEdit(object: NSManagedObject) -> Bool {
        return container.canUpdateRecord(forManagedObjectWith: object.objectID)
    }

    func canDelete(object: NSManagedObject) -> Bool {
        return container.canDeleteRecord(forManagedObjectWith: object.objectID)
    }

    func isOwner(object: NSManagedObject) -> Bool {
        guard isShared(object: object) else { return false }
        guard let share = try? container.fetchShares(matching: [object.objectID])[object.objectID] else {
            print("Get ckshare error")
            return false
        }
        if let currentUser = share.currentUserParticipant, currentUser == share.owner {
            return true
        }
        return false
    }

    // TODO: 分享
    /*
    func getShare(_ objcet: BFRecord) -> CKShare? {
        guard isShared(object: objcet) else { return nil }
        guard let share = try? container.fetchShares(matching: [objcet.objectID])[objcet.objectID] else {
            print("Get ckshare error")
            return nil
        }
        share[CKShare.SystemFieldKey.title] = objcet.name
        return share
    }
     */
}
