import Combine
import Foundation
import HCUtilKit
import HCNetworkKit
import SwiftUI

public class UserPreferences: ObservableObject {
    public static let sharedDefault = UserDefaults(suiteName: AppConfig.groupID)
    public static let shared = UserPreferences()
    
    private var client: Client?
    
    @AppStorage("selectedCalendarIdentifier") public var selectedCalendarIdentifier: Int = CalendarIdentifier.gregorian.rawValue

    @AppStorage("first-week-day") public var firstWeekDay: Int = 2
    
    @AppStorage("remote_local_timeline") public var remoteLocalTimelines: [String] = []
    @AppStorage("tag_groups") public var tagGroups: [TagGroup] = []
    @AppStorage("preferred_browser") public var preferredBrowser: PreferredBrowser = .inAppSafari
    @AppStorage("draft_posts") public var draftsPosts: [String] = []
    @AppStorage("show_translate_button_inline") public var showTranslateButton: Bool = true
    @AppStorage("is_open_ai_enabled") public var isOpenAIEnabled: Bool = true
    
    @AppStorage("recently_used_languages") public var recentlyUsedLanguages: [String] = []
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
    
    @AppStorage("swipeactions-status-trailing-right") public var swipeActionsStatusTrailingRight = StatusAction.favorite
    @AppStorage("swipeactions-status-trailing-left") public var swipeActionsStatusTrailingLeft = StatusAction.boost
    @AppStorage("swipeactions-status-leading-left") public var swipeActionsStatusLeadingLeft = StatusAction.reply
    @AppStorage("swipeactions-status-leading-right") public var swipeActionsStatusLeadingRight = StatusAction.none
    @AppStorage("swipeactions-use-theme-color") public var swipeActionsUseThemeColor = false
    @AppStorage("swipeactions-icon-style") public var swipeActionsIconStyle: SwipeActionsIconStyle = .iconWithText
    
    @AppStorage("requested_review") public var requestedReview = false
    
    @AppStorage("collapse-long-posts") public var collapseLongPosts = true
    
    @AppStorage("share-button-behavior") public var shareButtonBehavior: PreferredShareButtonBehavior = .linkAndText
    
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
    
    public func setClient(client: Client) {
        self.client = client
    }
    
    public func markLanguageAsSelected(isoCode: String) {
        var copy = recentlyUsedLanguages
        if let index = copy.firstIndex(of: isoCode) {
            copy.remove(at: index)
        }
        copy.insert(isoCode, at: 0)
        recentlyUsedLanguages = Array(copy.prefix(3))
    }
}