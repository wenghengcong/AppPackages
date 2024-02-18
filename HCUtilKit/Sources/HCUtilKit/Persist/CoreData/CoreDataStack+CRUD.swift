//
//  CoreDataStack.swift
//  Sunshine
//
//  Created by Nemo on 2023/4/27.
//

import Foundation
import CloudKit
import SwiftUI
import CoreData

public extension CoreDataStack {

    // MARK: - Create
    func create<T: NSManagedObject>(entityType: T.Type) -> T {
        return T(context: viewContext)
    }

    // MARK: - Delete
    func delete(_ entity: NSManagedObject) {
        viewContext.delete(entity)
        _ = saveContext()
    }

    func deleteAll(_ entityName: String) {
        if entityName.isEmpty  {
            return
        }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("delete core data \(error.debugDescription)")
        }
    }

    func delete<T: NSManagedObject>(_ entityType: T.Type, attribute:String, value:Any) {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        let predicate = NSPredicate(format: "%K == %@", attribute, value as! CVarArg)
        request.predicate = predicate

        do {
            let matchingObjects = try viewContext.fetch(request)
            for case let object as NSManagedObject in matchingObjects {
                viewContext.delete(object)
            }
            try viewContext.save()
        } catch {
            print("Error deleting entities by attribute: \(error)")
        }
    }

    // MARK: - Fetch
    func fetch<T: NSManagedObject>(_ entityType: T.Type) -> [T] {
        //        do {
        //            guard let result = try viewContext.fetch(entityType.fetchRequest()) as? [T] else {
        //                return nil
        //            }
        //            return result
        //        }catch let error {
        //            debugPrint(error)
        //            return nil
        //        }

        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching entities: \(error)")
            return []
        }
    }

    /// 获取实体
    /// - Parameters:
    ///   - entityType: 实体对象
    ///   - key: 业务Entity的key
    ///   - value: 值
    func fetchEntity<T: NSManagedObject, U: RawRepresentable>(_ entityType: T.Type, key: U, value: Any) -> [T] where U.RawValue == String {
        return fetch(entityType, attribute: key.rawValue, value: value)
    }
    
    
    /// 获取实体
    /// - Parameters:
    ///   - entityType: 实体对象
    ///   - key: CD_Key 通用字段
    ///   - value: 值
    func fetch<T: NSManagedObject>(_ entityType: T.Type, key: CD_KEY, value: Any) -> [T] {
        return fetch(entityType, attribute: key.rawValue, value: value)
    }

    func fetch<T: NSManagedObject>(_ entityType: T.Type, attribute: String, value: Any) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        let predicate = NSPredicate(format: "%K == %@", attribute, value as! CVarArg)
        request.predicate = predicate
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching entities by attribute: \(error)")
            return []
        }
    }

    func fetch<T: NSManagedObject>(_ entityType: T.Type, attributes: [String: Any]) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))

        var predicates = [NSPredicate]()
        for (key, value) in attributes {
            let predicate = NSPredicate(format: "%K == %@", key, value as! CVarArg)
            predicates.append(predicate)
        }

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = compoundPredicate

        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching entities by attributes: \(error)")
            return []
        }
    }

    /// 获取
    /// let coreDataManager = CoreDataManager.shared
    /// let searchAttributes = ["name": "John", "age": 25, "city": "New York"]
    /// let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    /// let people = coreDataManager.fetch(
    ///     entityType: Person.self,
    ///     attributes: searchAttributes,
    ///     sortDescriptors: sortDescriptors
    /// )
    func fetch<T: NSManagedObject>(
        _ entityType: T.Type,
        attributes: [String: Any],
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))

        var predicates = [NSPredicate]()
        for (key, value) in attributes {
            let predicate = NSPredicate(format: "%K == %@", key, value as! CVarArg)
            predicates.append(predicate)
        }

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = compoundPredicate

        request.sortDescriptors = sortDescriptors

        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching entities by attributes: \(error)")
            return []
        }
    }

    func fetch<T: NSManagedObject>(
        _ entityType: T.Type,
        attributes: [String: Any],
        sortKey: String?,
        ascending: Bool = true
    ) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))

        var predicates = [NSPredicate]()
        for (key, value) in attributes {
            let predicate = NSPredicate(format: "%K == %@", key, value as! CVarArg)
            predicates.append(predicate)
        }
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = compoundPredicate
        if let sortKey {
            let sortDescriptors = [NSSortDescriptor(key: sortKey, ascending: true)]
            request.sortDescriptors = sortDescriptors
        }
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching entities by attributes: \(error)")
            return []
        }
    }


    /// Mark: - Save
    func saveContext () -> Bool {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint(nserror)
                //                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
            return true
        }
        return false
    }

    // Mark: - Property
    func getMaxSort<T: NSManagedObject>(_ entityType: T.Type) -> Int? {
        let keyName = "sort"
        let entityName = String(describing: T.self)
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        fetchRequest.propertiesToFetch = [keyName]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: keyName, ascending: false)]
        fetchRequest.fetchLimit = 1

        do {
            let results = try viewContext.fetch(fetchRequest)
            return results.first?.value(forKey: keyName) as? Int
        } catch {
            print("Error fetching max sort: \(error)")
            return nil
        }
    }
}
