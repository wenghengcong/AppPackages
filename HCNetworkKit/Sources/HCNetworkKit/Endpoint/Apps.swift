import Foundation
import HCUtilKit

public enum Apps: Endpoint {
    case registerApp

    public func path() -> String {
        switch self {
        case .registerApp:
            "apps"
        }
    }

    public func queryItems() -> [URLQueryItem]? {
        switch self {
        case .registerApp:
            return [
                .init(name: "client_name", value: AppConfig.clientName),
                .init(name: "redirect_uris", value: AppConfig.scheme),
                .init(name: "scopes", value: AppConfig.scopes),
                .init(name: "website", value: AppConfig.weblink),
            ]
        }
    }
}
