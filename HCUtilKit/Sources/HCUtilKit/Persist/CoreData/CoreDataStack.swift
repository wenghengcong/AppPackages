//
//  Persistence.swift
//  Mirror
//
//  Created by Nemo on 2023/4/23.
//

import CoreData
import CloudKit

public class CoreDataStack {

    public static let shared = CoreDataStack()

    public static var preview: CoreDataStack = {
        let result = CoreDataStack(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    public let container: NSPersistentCloudKitContainer

    /// 上下文
    public lazy var viewContext = container.viewContext

    /// cloudkit container
    private var _cloudContainer: CKContainer!
    public var cloudContainer: CKContainer {
        if(_cloudContainer != nil) {
            return _cloudContainer
        }
        _cloudContainer = CKContainer(identifier: AppConfig.current.ckContainerID)
        return _cloudContainer
    }

    private var _privatePersistentStore: NSPersistentStore?

    /// 私有数据库
    public var privatePersistentStore: NSPersistentStore {
        return _privatePersistentStore!
    }

    private var _sharedPersistentStore: NSPersistentStore?
    public var sharedPersistentStore: NSPersistentStore {
        return _sharedPersistentStore!
    }

    private var _publicPersistentStore: NSPersistentStore?
    public var publicPersistentStore: NSPersistentStore {
        return _publicPersistentStore!
    }

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: AppConfig.current.ckContainerFile)
        if inMemory {   /// 主要用于Debug
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Failed to pin viewContext to the current generation:\(error)")
                }
            })
        } else {
            var dbURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            // group url
            if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppConfig.current.groupID) {
                dbURL = url
            }

            /// 视图上下文自动合并服务器端同步（import）来的数据。使用 @FetchRequest 或 NSFetchedResultsController 的视图可以将数据变化及时反应在 UI 上。
            container.viewContext.automaticallyMergesChangesFromParent = true
            ///  设定合并冲突策略。如果不设置该属性，Core Data 会默认使用 NSErrorMergePolicy 作为冲突解决策略（所有冲突都不处理，直接报错），这会导致 iCloud 的数据无法正确合并到本地数据库。
            ///  NSMergeByPropertyStoreTrumpMergePolicy: 逐属性比较，如果持久化数据和内存数据都改变且冲突，持久化数据胜出
            ///  NSMergeByPropertyObjectTrumpMergePolicy: 逐属性比较，如果持久化数据和内存数据都改变且冲突，内存数据胜出
            ///  NSOverwriteMergePolicy: 内存数据永远胜出
            ///  NSRollbackMergePolicy: 持久化数据永远胜出
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            do {
                /// 避免在数据导入期间应用程序产生的数据变化和导入数据不一致而可能出现的不稳定情况
                try container.viewContext.setQueryGenerationFrom(.current)
            } catch {
                fatalError("Failed to pin viewContext to the current generation:\(error)")
            }

            //MARK: - Cloud
            //MARK: private
            // private
            let cloudPrivateURL = dbURL.appendingPathComponent("cloud.sqlite")
            let cloudPrivateDesc = NSPersistentStoreDescription(url: cloudPrivateURL)
            /// 控制是否启用数据网络同步功能，在Scheme设置allowCloudKitSync为 0 将关闭网络同步。
            if CoreDataStackSwitch.allowCloudKitSync {
                cloudPrivateDesc.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: AppConfig.current.ckContainerID)
            } else {
                cloudPrivateDesc.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
                cloudPrivateDesc.setOption(true as NSNumber,
                                           forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            }
            cloudPrivateDesc.configuration = "Cloud"
            cloudPrivateDesc.cloudKitContainerOptions?.databaseScope = .private

            //MARK: share
            // share
            guard let cloudShareDesc = cloudPrivateDesc.copy() as? NSPersistentStoreDescription else {
                fatalError("Create shareDesc error")
            }
            cloudShareDesc.configuration = "Share"
            cloudShareDesc.url = dbURL.appendingPathComponent("cloud_share.sqlite")

            if CoreDataStackSwitch.allowCloudKitSync {
                cloudShareDesc.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: AppConfig.current.ckContainerID)
            } else {
                cloudShareDesc.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
                cloudShareDesc.setOption(true as NSNumber,
                                         forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            }
            cloudShareDesc.cloudKitContainerOptions?.databaseScope = .shared

            //MARK: public
            // public
            guard let cloudPublicDesc = cloudPrivateDesc.copy() as? NSPersistentStoreDescription else {
                fatalError("Create publicDesc error")
            }
            cloudPublicDesc.configuration = "Public"
            cloudPublicDesc.url = dbURL.appendingPathComponent("cloud_public.sqlite")

            if CoreDataStackSwitch.allowCloudKitSync {
                cloudPublicDesc.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: AppConfig.current.ckContainerID)
            } else {
                cloudPublicDesc.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
                cloudPublicDesc.setOption(true as NSNumber,
                                          forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            }
            cloudPublicDesc.cloudKitContainerOptions?.databaseScope = .public

            //MARK: - Local
            let localURL = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first!
                .appendingPathComponent("local.sqlite")
            let localDesc = NSPersistentStoreDescription(url: localURL)
            localDesc.configuration = "Local"

            container.persistentStoreDescriptions = [cloudPrivateDesc, cloudPublicDesc, cloudShareDesc, localDesc]
            container.loadPersistentStores(completionHandler: { (desc, error) in

                if let err = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("DB init error:\(err.localizedDescription)")
                } else if let cloudKitContiainerOptions = desc.cloudKitContainerOptions {
                    switch cloudKitContiainerOptions.databaseScope {
                    case .public:
                        self._publicPersistentStore = self.container.persistentStoreCoordinator.persistentStore(for: cloudPublicDesc.url!)
                    case .private:
                        self._privatePersistentStore = self.container.persistentStoreCoordinator.persistentStore(for: cloudPrivateDesc.url!)
                    case .shared:
                        self._sharedPersistentStore = self.container.persistentStoreCoordinator.persistentStore(for: cloudShareDesc.url!)
                    default:
                        break
                    }
                }
            })
        }
    }
}
