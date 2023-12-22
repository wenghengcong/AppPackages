import Combine
import SwiftUI

public class Theme: ObservableObject, Equatable {
    /// 主题的Key
    enum ThemeKey: String {
        /// scheme，对应是dark还是light
        case colorScheme
        case tint, primaryBackground, secondaryBackground
        case label, secondLabel,separator,placeholder
        
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

    @AppStorage(ThemeKey.selectedSet.rawValue) var storedSet: HCColorSetName = .systemDark
    @AppStorage(ThemeKey.followSystemColorSchme.rawValue) public var followSystemColorScheme: Bool = true
    @AppStorage(ThemeKey.displayFullUsernameTimeline.rawValue) public var displayFullUsername: Bool = true
    @AppStorage(ThemeKey.lineSpacing.rawValue) public var lineSpacing: Double = 0.8
    @AppStorage("font_size_scale") public var fontSizeScale: Double = 1
    @AppStorage("chosen_font") public private(set) var chosenFontData: Data?
    
    @Published public var selectedSet: HCColorSetName = .systemDark
    
    private var cancellables = Set<AnyCancellable>()
    
    public static let shared = Theme()
    
    private init(colorOverrides: [HCColorToken: Color]? = nil,
                 shadowOverrides: [ShadowToken: HCShadowInfo]? = nil,
                 typographyOverrides: [HCTypographyToken: HCFontInfo]? = nil,
                 gradientOverrides: [HCGradientToken: [Color]]? = nil) {
        
        let colorTokenSet = HCTokenSet<HCColorToken, Color>(Theme.defaultColors(_:), colorOverrides)
        let shadowTokenSet = HCTokenSet<ShadowToken, HCShadowInfo>(Theme.defaultShadows(_:), shadowOverrides)
        let typographyTokenSet = HCTokenSet<HCTypographyToken, HCFontInfo>(Theme.defaultTypography(_:), typographyOverrides)
        let gradientTokenSet = HCTokenSet<HCGradientToken, [Color]>({ [colorTokenSet] token in
            // Reference the colorTokenSet as part of the gradient lookup
            return Theme.defaultGradientColors(token, colorTokenSet: colorTokenSet)
        })

        self.colorTokenSet = colorTokenSet
        self.shadowTokenSet = shadowTokenSet
        self.typographyTokenSet = typographyTokenSet
        self.gradientTokenSet = gradientTokenSet
        
        selectedSet = storedSet
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
            SystemLight(),
            SystemDark(),
        ]
    }
    
    public func setColor(withName name: HCColorSetName) {
        let HCColorSet = Theme.allHCColorSet.filter { $0.name == name }.first ?? SystemLight()
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
    
    public static func ==(lhs: Theme, rhs: Theme) -> Bool {
        return lhs.selectedScheme == rhs.selectedScheme && lhs.tintColor == rhs.tintColor
    }
    
    
    // Token storage
    let colorTokenSet: HCTokenSet<HCColorToken, Color>
    let shadowTokenSet: HCTokenSet<ShadowToken, HCShadowInfo>
    let typographyTokenSet: HCTokenSet<HCTypographyToken, HCFontInfo>
    let gradientTokenSet: HCTokenSet<HCGradientToken, [Color]>
    
    private func tokenKey<T: HCTokenSetKey>(_ tokenSetType: HCControlTokenSet<T>.Type) -> String {
        return "\(tokenSetType)"
    }
    
    /// Registers a custom set of `ControlTokenValue` instances for a given `ControlTokenSet`.
    ///
    /// - Parameters:
    ///   - tokenSetType: The token set type to register custom tokens for.
    ///   - tokens: A custom set of tokens to register.
    public func register<T: HCTokenSetKey>(tokenSetType: HCControlTokenSet<T>.Type, tokenSet: [T: HCControlTokenValue]?) {
        controlTokenSets[tokenKey(tokenSetType)] = tokenSet
    }

    private var controlTokenSets: [String: Any] = [:]
    
    /// Returns the `ControlTokenValue` array for a given `TokenizedControl`, if any overrides have been registered.
    ///
    /// - Parameter tokenSetType: The token set type to fetch the token overrides for.
    ///
    /// - Returns: An array of `ControlTokenValue` instances for the given control, or `nil` if no custom tokens have been registered.
    public func tokens<T: HCTokenSetKey>(for tokenSetType: HCControlTokenSet<T>.Type) -> [T: HCControlTokenValue]? {
        return controlTokenSets[tokenKey(tokenSetType)] as? [T: HCControlTokenValue]
    }
}
