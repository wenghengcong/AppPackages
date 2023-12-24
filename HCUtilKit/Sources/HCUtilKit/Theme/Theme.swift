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
    
    @AppStorage(ThemeKey.selectedScheme.rawValue) public var selectedScheme: ThemeScheme = .light
    @AppStorage(ThemeKey.tint.rawValue) public var tintColor: Color = .black
    @AppStorage(Theme.ColorToken.background.rawValue) public var background: Color = .white
    @AppStorage(Theme.ColorToken.foreground.rawValue) public var foreground: Color = .gray
    @AppStorage(ThemeKey.label.rawValue) public var labelColor: Color = .black
    @AppStorage(ThemeKey.secondLabel.rawValue) public var secondLabelColor: Color = .black
    @AppStorage(ThemeKey.separator.rawValue) public var separatorColor: Color = .lightGray
    @AppStorage(ThemeKey.placeholder.rawValue) public var placeholderColor: Color = .lightGray

    @AppStorage(ThemeKey.selectedSet.rawValue) var storedSet: ThemeName = .systemDark
    @AppStorage(ThemeKey.followSystemColorSchme.rawValue) public var followSystemColorScheme: Bool = true
    @AppStorage(ThemeKey.displayFullUsernameTimeline.rawValue) public var displayFullUsername: Bool = true
    @AppStorage(ThemeKey.lineSpacing.rawValue) public var lineSpacing: Double = 0.8
    @AppStorage("font_size_scale") public var fontSizeScale: Double = 1
    @AppStorage("chosen_font") public private(set) var chosenFontData: Data?
    
    @Published public var selectedSet: ThemeName = .systemDark
    // Token storage
    var colorTokenSet: HCTokenSet<ColorToken, Color>
    var shadowTokenSet: HCTokenSet<ShadowToken, HCShadowInfo>
    var typographyTokenSet: HCTokenSet<TypographyToken, HCFontInfo>
    var gradientTokenSet: HCTokenSet<GradientToken, [Color]>

    private var controlTokenSets: [String: Any] = [:]

    private var cancellables = Set<AnyCancellable>()
    
    public static let shared = Theme()
    
    /// 单例对象
    public static var systemDark = SystemDark()
    public static var systemLight = SystemLight()

    public var current: ThemeSet {
        return Theme.allThemeSet.filter { $0.name == self.selectedSet }.first ?? SystemLight()
    }

    private init() {
        selectedScheme = .light

        self.colorTokenSet = Theme.systemLight.colorTokenSet
        self.shadowTokenSet = Theme.systemLight.shadowTokenSet
        self.typographyTokenSet = Theme.systemLight.typographyTokenSet
        self.gradientTokenSet = Theme.systemLight.gradientTokenSet

        selectedSet = storedSet

        // Workaround, since @AppStorage can't be directly observed
        $selectedSet
            .dropFirst()
            .sink { [weak self] name in
                self?.refreshTheme(withName: name)
            }
            .store(in: &cancellables)
    }
    
    public static var allThemeSet: [ThemeSet] {
        return [
            systemLight,
            systemDark,
        ]
    }

    public func refreshColorSet(_ colors: [ColorToken: Color]) {
        self.colorTokenSet.update(colors)
    }

    public func refreshTheme(withName name: ThemeName) {
        let ThemeSet = Theme.allThemeSet.filter { $0.name == name }.first ?? SystemLight()
        selectedScheme = ThemeSet.scheme
        self.colorTokenSet = ThemeSet.colorTokenSet
        self.shadowTokenSet = ThemeSet.shadowTokenSet
        self.typographyTokenSet = ThemeSet.typographyTokenSet
        self.gradientTokenSet = ThemeSet.gradientTokenSet

        background = self.color(.background)
        foreground = self.color(.foreground)
        storedSet = name
    }

    public static var isDarkMode: Bool {
        let isDark = (Theme.shared.selectedScheme == .dark)
        return isDark
    }
    
    public static func ==(lhs: Theme, rhs: Theme) -> Bool {
        return lhs.selectedScheme == rhs.selectedScheme && lhs.tintColor == rhs.tintColor
    }
}

// MARK: - Token
public extension Theme {

    private func tokenKey<T: HCTokenSetKey>(_ tokenSetType: HCControlTokenSet<T>.Type) -> String {
        return "\(tokenSetType)"
    }

    /// Registers a custom set of `ControlTokenValue` instances for a given `ControlTokenSet`.
    ///
    /// - Parameters:
    ///   - tokenSetType: The token set type to register custom tokens for.
    ///   - tokens: A custom set of tokens to register.
    func register<T: HCTokenSetKey>(tokenSetType: HCControlTokenSet<T>.Type, tokenSet: [T: HCControlTokenValue]?) {
        controlTokenSets[tokenKey(tokenSetType)] = tokenSet
    }

    /// Returns the `ControlTokenValue` array for a given `TokenizedControl`, if any overrides have been registered.
    ///
    /// - Parameter tokenSetType: The token set type to fetch the token overrides for.
    ///
    /// - Returns: An array of `ControlTokenValue` instances for the given control, or `nil` if no custom tokens have been registered.
    func tokens<T: HCTokenSetKey>(for tokenSetType: HCControlTokenSet<T>.Type) -> [T: HCControlTokenValue]? {
        return controlTokenSets[tokenKey(tokenSetType)] as? [T: HCControlTokenValue]
    }

    /// Returns the color value for the given token.
    ///
    /// - Parameter token: The `ColorsTokens` value to be retrieved.
    /// - Returns: A `Color` for the given token.
    func color(_ token: ColorToken) -> Color {
        return colorTokenSet[token]
    }

    /// Returns the shadow value for the given token.
    ///
    /// - Parameter token: The `ShadowTokens` value to be retrieved.
    /// - Returns: A `HCShadowInfo` for the given token.
    func shadow(_ token: ShadowToken) -> HCShadowInfo {
        return shadowTokenSet[token]
    }

    /// Returns the font value for the given token.
    ///
    /// - Parameter token: The `TypographyTokens` value to be retrieved.
    /// - Returns: A `Font` for the given token.
    func typography(_ token: TypographyToken) -> Font {
        return Font.info(typographyTokenSet[token])
    }

    /// Returns an array of colors for the given token.
    ///
    /// - Parameter token: The `HCGradientTokens` value to be retrieved.
    /// - Returns: An array of `Color` values for the given token.
    func gradient(_ token: GradientToken) -> [Color] {
        return gradientTokenSet[token]
    }
}
