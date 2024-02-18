//
//  CoreDataStack+Func.swift
//
//
//  Created by Nemo on 2024/2/19.
//

import Foundation

public func CD_SaveContent() {
    _ = CoreDataStack.shared.saveContext()
}
