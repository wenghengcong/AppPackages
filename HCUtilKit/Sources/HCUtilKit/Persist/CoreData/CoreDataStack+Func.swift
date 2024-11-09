//
//  CoreDataStack+Func.swift
//
//
//  Created by Nemo on 2024/2/19.
//

import Foundation

public func CD_SaveContent(completion: ((Bool, Error?) -> Void)? = nil) {
    CoreDataStack.shared.saveContext(completion: completion)
}
