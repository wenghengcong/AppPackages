import Combine
import Foundation
import HCUtilKit
import HCNetworkKit
import SwiftUI

public enum RouterDestination: Hashable {
    case accountDetail(id: String)
    case statusDetail(id: String)
    case remoteStatusDetail(url: URL)
    case hashTag(tag: String, account: String?)
    case followers(id: String)
    case following(id: String)
    case favoritedBy(id: String)
    case rebloggedBy(id: String)
    case trendingTimeline
    case tagsList(tags: [Tag])
}

public enum SheetDestination: Identifiable {
    case addAccount
    case addRemoteLocalTimeline
    case addTagGroup
    case statusEditHistory(status: String)
    case settings
    case accountPushNotficationsSettings
    case editTagGroup(tagGroup: TagGroup, onSaved: ((TagGroup) -> Void)?)
    
    public var id: String {
        switch self {
        case .addTagGroup:
            "addTagGroup"
        case .addRemoteLocalTimeline:
            "addRemoteLocalTimeline"
        case .statusEditHistory:
            "statusEditHistory"
        case .editTagGroup:
            "editTagGroup"

        case .addAccount:
            "editTagGroup"

        case .settings:
            "editTagGroup"

        case .accountPushNotficationsSettings:
            "editTagGroup"

        }
    }
}

@MainActor
public class RouterPath: ObservableObject {
    public var client: Client?
    public var urlHandler: ((URL) -> OpenURLAction.Result)?
    
    @Published public var path: [RouterDestination] = []
    @Published public var presentedSheet: SheetDestination?
    
    public init() {}
    
    public func navigate(to: RouterDestination) {
        path.append(to)
    }

    public func handle(url: URL) -> OpenURLAction.Result {
        if url.pathComponents.contains(where: { $0 == "tags" }),
           let tag = url.pathComponents.last
        {
            navigate(to: .hashTag(tag: tag, account: nil))
            return .handled
        } else if url.lastPathComponent.first == "@", let host = url.host {
            let acct = "\(url.lastPathComponent)@\(host)"
            Task {

            }
            return .handled
        } else if let client,
                  client.isAuth,
                  client.hasConnection(with: url),
                  let id = Int(url.lastPathComponent)
        {
            if url.absoluteString.contains(client.server) {
                navigate(to: .statusDetail(id: String(id)))
            } else {
                navigate(to: .remoteStatusDetail(url: url))
            }
            return .handled
        }
        return urlHandler?(url) ?? .systemAction
    }
}
