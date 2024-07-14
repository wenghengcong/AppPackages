//
//  CloudKitStack.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/23.
//

import Foundation

import CloudKit


public class CloudKitStack {
    static let shared = CloudKitStack()
    
    func status(completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataStack.shared.cloudContainer.accountStatus { status, error in
            print("\(status)")
        }
    }
    
}
