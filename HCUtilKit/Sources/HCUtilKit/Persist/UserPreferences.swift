import Combine
import Foundation
import SwiftUI

public class UserPreferences: ObservableObject {
    public static let sharedDefault = UserDefaults(suiteName: AppConfig.groupID)
    public static let shared = UserPreferences()

    @AppStorage("selectedCalendarIdentifier") public var selectedCalendarIdentifier: Int = CalendarIdentifier.gregorian.rawValue

    @AppStorage("first-week-day") public var firstWeekDay: Int = 2
    

    @AppStorage("show_translate_button_inline") public var showTranslateButton: Bool = true
    @AppStorage("is_open_ai_enabled") public var isOpenAIEnabled: Bool = true
    
    @AppStorage("social_keyboard_composer") public var isSocialKeyboardEnabled: Bool = true
    
    @AppStorage("use_instance_content_settings") public var useInstanceContentSettings: Bool = true
    @AppStorage("app_auto_expand_spoilers") public var appAutoExpandSpoilers = false
    
    @AppStorage("app_default_posts_sensitive") public var appDefaultPostsSensitive = false
    @AppStorage("autoplay_video") public var autoPlayVideo = true
    @AppStorage("always_use_deepl") public var alwaysUseDeepl = false
    @AppStorage("user_deepl_api_free") public var userDeeplAPIFree = true
    @AppStorage("auto_detect_post_language") public var autoDetectPostLanguage = true
    
    @AppStorage("suppress_dupe_reblogs") public var suppressDupeReblogs: Bool = false
    
    @AppStorage("inAppBrowserReaderView") public var inAppBrowserReaderView = false
    
    @AppStorage("haptic_tab") public var hapticTabSelectionEnabled = true
    @AppStorage("haptic_timeline") public var hapticTimelineEnabled = true
    @AppStorage("haptic_button_press") public var hapticButtonPressEnabled = true
    @AppStorage("sound_effect_enabled") public var soundEffectEnabled = true
    
    @AppStorage("show_tab_label_iphone") public var showiPhoneTabLabel = true
    @AppStorage("show_alt_text_for_media") public var showAltTextForMedia = true
    
    @AppStorage("show_second_column_ipad") public var showiPadSecondaryColumn = true

    @AppStorage("swipeactions-use-theme-color") public var swipeActionsUseThemeColor = false
    @AppStorage("swipeactions-icon-style") public var swipeActionsIconStyle: SwipeActionsIconStyle = .iconWithText
    
    @AppStorage("requested_review") public var requestedReview = false
    
    @AppStorage("collapse-long-posts") public var collapseLongPosts = true

    public enum SwipeActionsIconStyle: String, CaseIterable {
        case iconWithText, iconOnly
        
        public var description: LocalizedStringKey {
            switch self {
            case .iconWithText:
                "enum.swipeactions.icon-with-text"
            case .iconOnly:
                "enum.swipeactions.icon-only"
            }
        }
        
        // Have to implement this manually here due to compiler not implicitly
        // inserting `nonisolated`, which leads to a warning:
        //
        //     Main actor-isolated static property 'allCases' cannot be used to
        //     satisfy nonisolated protocol requirement
        //
        public nonisolated static var allCases: [Self] {
            [.iconWithText, .iconOnly]
        }
    }

    
    public func setNotification(count: Int, token: OauthToken) {
        Self.sharedDefault?.set(count, forKey: "push_notifications_count_\(token.createdAt)")
        objectWillChange.send()
    }
    
    public func getNotificationsCount(for token: OauthToken) -> Int {
        Self.sharedDefault?.integer(forKey: "push_notifications_count_\(token.createdAt)") ?? 0
    }
    
    public func getNotificationsTotalCount(for tokens: [OauthToken]) -> Int {
        var count = 0
        for token in tokens {
            count += getNotificationsCount(for: token)
        }
        return count
    }

    private init() {}
}
