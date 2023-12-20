import Combine
import SwiftUI
import HCUtilKit

public class Theme: ObservableObject {
    /// 主题的Key
    enum ThemeKey: String {
        /// scheme，对应是dark还是light
        case colorScheme
        case tint, primaryBackground, secondaryBackground
        case label, secondLabel,separator,placeholder
        
        case avatarPosition, avatarShape, statusActionsDisplay, statusDisplayStyle
        case selectedSet, selectedScheme
        case followSystemColorSchme
        case displayFullUsernameTimeline
        case lineSpacing
    }
    
    public enum FontState: Int, CaseIterable {
        case system
        case openDyslexic
        case hyperLegible
        case SFRounded
        case custom
        
        @MainActor
        public var title: LocalizedStringKey {
            switch self {
            case .system:
                "settings.display.font.system"
            case .openDyslexic:
                "Open Dyslexic"
            case .hyperLegible:
                "Hyper Legible"
            case .SFRounded:
                "SF Rounded"
            case .custom:
                "settings.display.font.custom"
            }
        }
    }
    
    public enum AvatarPosition: String, CaseIterable {
        case leading, top
        
        public var description: LocalizedStringKey {
            switch self {
            case .leading:
                "enum.avatar-position.leading"
            case .top:
                "enum.avatar-position.top"
            }
        }
    }
    
    public enum AvatarShape: String, CaseIterable {
        case circle, rounded
        
        public var description: LocalizedStringKey {
            switch self {
            case .circle:
                "enum.avatar-shape.circle"
            case .rounded:
                "enum.avatar-shape.rounded"
            }
        }
    }
    
    public enum StatusActionsDisplay: String, CaseIterable {
        case full, discret, none
        
        public var description: LocalizedStringKey {
            switch self {
            case .full:
                "enum.status-actions-display.all"
            case .discret:
                "enum.status-actions-display.only-buttons"
            case .none:
                "enum.status-actions-display.no-buttons"
            }
        }
    }
    
    public enum StatusDisplayStyle: String, CaseIterable {
        case large, medium, compact
        
        public var description: LocalizedStringKey {
            switch self {
            case .large:
                "enum.status-display-style.large"
            case .medium:
                "enum.status-display-style.medium"
            case .compact:
                "enum.status-display-style.compact"
            }
        }
    }
    
    private var _cachedChoosenFont: HCUniversalFont?
    public var chosenFont: HCUniversalFont? {
        get {
            if let _cachedChoosenFont {
                return _cachedChoosenFont
            }
            guard let chosenFontData,
                  let font = try? NSKeyedUnarchiver.unarchivedObject(ofClass: HCUniversalFont.self, from: chosenFontData) else { return nil }
            
            _cachedChoosenFont = font
            return font
        }
        set {
            if let font = newValue,
               let data = try? NSKeyedArchiver.archivedData(withRootObject: font, requiringSecureCoding: false)
            {
                chosenFontData = data
            } else {
                chosenFontData = nil
            }
            _cachedChoosenFont = nil
        }
    }
    
    @AppStorage("is_previously_set") public var isThemePreviouslySet: Bool = false
    
    @AppStorage(ThemeKey.selectedScheme.rawValue) public var selectedScheme: HCColorScheme = .dark
    @AppStorage(ThemeKey.tint.rawValue) public var tintColor: Color = .black
    @AppStorage(ThemeKey.primaryBackground.rawValue) public var primaryBackgroundColor: Color = .white
    @AppStorage(ThemeKey.secondaryBackground.rawValue) public var secondaryBackgroundColor: Color = .gray
    @AppStorage(ThemeKey.label.rawValue) public var labelColor: Color = .black
    @AppStorage(ThemeKey.secondLabel.rawValue) public var secondLabelColor: Color = .black
    @AppStorage(ThemeKey.separator.rawValue) public var separatorColor: Color = .lightGray
    @AppStorage(ThemeKey.placeholder.rawValue) public var placeholderColor: Color = .lightGray

    
    @AppStorage(ThemeKey.avatarPosition.rawValue) var rawAvatarPosition: String = AvatarPosition.top.rawValue
    @AppStorage(ThemeKey.avatarShape.rawValue) var rawAvatarShape: String = AvatarShape.rounded.rawValue
    @AppStorage(ThemeKey.selectedSet.rawValue) var storedSet: HCColorSetName = .systemDark
    @AppStorage(ThemeKey.statusActionsDisplay.rawValue) public var statusActionsDisplay: StatusActionsDisplay = .full
    @AppStorage(ThemeKey.statusDisplayStyle.rawValue) public var statusDisplayStyle: StatusDisplayStyle = .large
    @AppStorage(ThemeKey.followSystemColorSchme.rawValue) public var followSystemColorScheme: Bool = true
    @AppStorage(ThemeKey.displayFullUsernameTimeline.rawValue) public var displayFullUsername: Bool = true
    @AppStorage(ThemeKey.lineSpacing.rawValue) public var lineSpacing: Double = 0.8
    @AppStorage("font_size_scale") public var fontSizeScale: Double = 1
    @AppStorage("chosen_font") public private(set) var chosenFontData: Data?
    
    @Published public var avatarPosition: AvatarPosition = .top
    @Published public var avatarShape: AvatarShape = .rounded
    @Published public var selectedSet: HCColorSetName = .systemDark
    
    private var cancellables = Set<AnyCancellable>()
    
    public static let shared = Theme()
    
    private init() {
        selectedSet = storedSet
        
        avatarPosition = AvatarPosition(rawValue: rawAvatarPosition) ?? .top
        avatarShape = AvatarShape(rawValue: rawAvatarShape) ?? .rounded
        
        $avatarPosition
            .dropFirst()
            .map(\.rawValue)
            .sink { [weak self] position in
                self?.rawAvatarPosition = position
            }
            .store(in: &cancellables)
        
        $avatarShape
            .dropFirst()
            .map(\.rawValue)
            .sink { [weak self] shape in
                self?.rawAvatarShape = shape
            }
            .store(in: &cancellables)
        
        // Workaround, since @AppStorage can't be directly observed
        $selectedSet
            .dropFirst()
            .sink { [weak self] HCColorSetName in
                self?.setColor(withName: HCColorSetName)
            }
            .store(in: &cancellables)
    }
    
    public static var allHCColorSet: [HCColorSet] {
        [
            SystemDark(),
            SystemLight()
        ]
    }
    
    public func setColor(withName name: HCColorSetName) {
        let HCColorSet = Theme.allHCColorSet.filter { $0.name == name }.first ?? SystemDark()
        selectedScheme = HCColorSet.scheme
        tintColor = HCColorSet.tintColor
        primaryBackgroundColor = HCColorSet.primaryBackgroundColor
        secondaryBackgroundColor = HCColorSet.secondaryBackgroundColor
        labelColor = HCColorSet.labelColor
        secondLabelColor = HCColorSet.sedondLabelColor
        separatorColor = HCColorSet.separatorColor
        placeholderColor = HCColorSet.placeholderColor
        storedSet = name
    }
    
    
    public static var isDarkMode: Bool {
        let isDark = (Theme.shared.selectedScheme == .dark)
        return isDark
    }
}