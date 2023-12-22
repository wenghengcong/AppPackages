//
//  HCNotification.swift
//  
//
//  Created by Nemo on 2023/12/22.
//

import Foundation

public struct HCNotification: Decodable, Identifiable, Equatable {
  public enum HCNotificationType: String, CaseIterable {
    case follow, follow_request, mention, reblog, status, favourite, poll, update
  }

  public let id: String
  public let type: String
  public let createdAt: ServerDate
  public let account: Account
  public let status: Status?

  public var supportedType: HCNotificationType? {
    .init(rawValue: type)
  }

  public static func placeholder() -> HCNotification {
    .init(id: UUID().uuidString,
          type: HCNotificationType.favourite.rawValue,
          createdAt: ServerDate(),
          account: .placeholder(),
          status: .placeholder())
  }
}

extension HCNotification: Sendable {}
extension HCNotification.HCNotificationType: Sendable {}
