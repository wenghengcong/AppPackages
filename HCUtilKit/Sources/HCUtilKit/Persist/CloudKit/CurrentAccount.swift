//
//  CloudKitUserBootcamp.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/23.
//

import Foundation
import SwiftUI
import Combine
import CloudKit

public class Account: Identifiable, Hashable, Equatable, Codable {
    public let id: String
    public var namePrefix: String?
    public var givenName: String?
    public var middleName: String?
    public var familyName: String?
    public var nameSuffix: String?
    public var nickname: String?
    public var contactIdentifiers: [String]?
    public var hasiCloudAccount: Bool
    public var recordName: String?
    public var zoneName: String?
    public var zoneOwnerName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case namePrefix
        case givenName
        case middleName
        case familyName
        case nameSuffix
        case nickname
        case contactIdentifiers
        case hasiCloudAccount
        case recordName
        case zoneName
        case zoneOwnerName
    }

    init(id: String, namePrefix: String? = nil, givenName: String? = nil, middleName: String? = nil, familyName: String? = nil, nameSuffix: String? = nil, nickname: String? = nil, contactIdentifiers: [String]? = nil, hasiCloudAccount: Bool, recordName: String? = nil, zoneName: String? = nil, zoneOwnerName: String? = nil) {
        self.id = id
        self.namePrefix = namePrefix
        self.givenName = givenName
        self.middleName = middleName
        self.familyName = familyName
        self.nameSuffix = nameSuffix
        self.nickname = nickname
        self.contactIdentifiers = contactIdentifiers
        self.hasiCloudAccount = hasiCloudAccount
        self.recordName = recordName
        self.zoneName = zoneName
        self.zoneOwnerName = zoneOwnerName
    }

    public static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }


    // TODO:
    public static func placeholder() -> Account {
        .init(id: "", hasiCloudAccount: true)
    }

    public static func placeholders() -> [Account] {
        [.placeholder(), .placeholder(), .placeholder(), .placeholder(), .placeholder(),
         .placeholder(), .placeholder(), .placeholder(), .placeholder(), .placeholder()]
    }
}


extension Account: JSONWritable, JSONReadable {}

public class CurrentAccount: ObservableObject {
    
    @Published public private(set) var account: Account?
    public static let shared = CurrentAccount()

    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""

    /// 用户信息
    @Published var userIdentify: CKUserIdentity?
    /// 用户name
    @Published var userName: String = ""

    var cancellables = Set<AnyCancellable>()

    init() {
        getiCloudStatus()
        requestPermission()
        getCurrentUser()
    }

    private func getiCloudStatus() {
        CloudKitUtility.getiCloudStatus()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                self?.isSignedInToiCloud = success
            }
            .store(in: &cancellables)
    }

    func requestPermission() {
        CloudKitUtility.requestApplicationPermission()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] success in
                self?.permissionStatus = success
            }
            .store(in: &cancellables)
    }

    func getCurrentUserName() {
        CloudKitUtility.discoverUserIdentity()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] returnedName in
                self?.userName = returnedName
            }
            .store(in: &cancellables)
    }


    func getCurrentUser() {
        if let account = readAccountFromLocal() {
            self.account = account
        }
        CloudKitUtility.discoverUser()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] userIdentify in
                self?.saveUser(user: userIdentify)
            }
            .store(in: &cancellables)
    }

    func saveUser(user: CKUserIdentity) {
        self.userIdentify = user
        if let recordID = user.userRecordID?.recordName {
            let account = ckUserToAccount(user: user)

            self.account = account
            

        }
        if let givenName = user.nameComponents?.givenName {
            self.userName = givenName
        }
    }

    func accountStorePath() -> FileKitPath {
        let path: FileKitPath = .userDocuments + "account.json"
        return path
    }

    func saveAccountToLocal(account: Account) {
        let path = accountStorePath()
        let codableFile = File<Account>(path: path)
        do {
            try codableFile.write(account)
        } catch {

        }
    }

    func readAccountFromLocal() -> Account? {
        let path = accountStorePath()
        let codableFile = File<Account>(path: path)
        var localAccount: Account?
        do {
            localAccount = try codableFile.read()
        } catch {
            localAccount = nil
        }
        return localAccount
    }

    func ckUserToAccount(user: CKUserIdentity) -> Account {
        var id: String
        let hasAccount = user.hasiCloudAccount
        if let userRecordID = user.userRecordID?.recordName {
            id = userRecordID
        } else {
            id = UUID().uuidString
        }
        let account = Account(id: id, hasiCloudAccount: hasAccount)
        if let nameComponents = user.nameComponents {
            account.namePrefix = nameComponents.namePrefix
            account.givenName = nameComponents.givenName
            account.middleName = nameComponents.middleName
            account.familyName = nameComponents.familyName
            account.nameSuffix = nameComponents.nameSuffix
            account.nickname = nameComponents.nickname
        }
        account.contactIdentifiers = user.contactIdentifiers
        account.recordName = user.userRecordID?.recordName
        account.zoneName = user.userRecordID?.zoneID.zoneName
        account.zoneOwnerName = user.userRecordID?.zoneID.ownerName
        return account
    }
}

struct CloudKitUserBootcamp: View {

    @StateObject private var vm = CurrentAccount()

    var body: some View {
        VStack {
            Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text("NAME: \(vm.userName)")
        }
    }
}

struct CloudKitUserBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitUserBootcamp()
    }
}
