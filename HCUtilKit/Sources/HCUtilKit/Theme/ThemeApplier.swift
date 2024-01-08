import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public extension View {
    func applyTheme(_ theme: Theme) -> some View {
        modifier(ThemeApplier(theme: theme))
    }
}

struct ThemeApplier: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    
    @ObservedObject var theme: Theme
    
    var actualColorScheme: SwiftUI.ColorScheme? {
        if theme.followSystemColorScheme {
            return nil
        }
        return theme.selectedScheme == Theme.ThemeScheme.dark ? .dark : .light
    }
    
    func body(content: Content) -> some View {
        content
            .tint(.themeTint)
            .preferredColorScheme(actualColorScheme)
#if canImport(UIKit)
            .onAppear {
                // If theme is never set before set the default store. This should only execute once after install.
                if !theme.isThemePreviouslySet {
                    theme.selectedTheme = colorScheme == .dark ? .systemDark : .systemLight
                    theme.isThemePreviouslySet = true
                } else if theme.followSystemColorScheme, theme.isThemePreviouslySet,
                          let sets = availableThemeSets
                    .first(where: { $0.light.name == theme.selectedTheme || $0.dark.name == theme.selectedTheme })
                {
                    theme.selectedTheme = colorScheme == .dark ? sets.dark.name : sets.light.name
                }
                setWindowTint(.themeTint)
                setWindowUserInterfaceStyle(from: theme.selectedScheme)
                setBarsColor(theme.color(.background))
            }
            .onChange(of: .themeTint) { newValue in
                setWindowTint(newValue)
            }
            .onChange(of: .themeTint) { newValue in
                setBarsColor(newValue)
            }
            .onChange(of: theme.selectedScheme) { newValue in
                setWindowUserInterfaceStyle(from: newValue)
            }
            .onChange(of: colorScheme) { newColorScheme in
                if theme.followSystemColorScheme,
                   let sets = availableThemeSets
                    .first(where: { $0.light.name == theme.selectedTheme || $0.dark.name == theme.selectedTheme })
                {
                    theme.selectedTheme = newColorScheme == .dark ? sets.dark.name : sets.light.name
                    NotificationCenter.default.post(name: .hcBusiness.didChangeTheme, object: nil)
                }
            }
#endif
    }
    
#if canImport(UIKit)
    private func setWindowUserInterfaceStyle(from colorScheme: Theme.ThemeScheme) {
        guard !theme.followSystemColorScheme else {
            setWindowUserInterfaceStyle(.unspecified)
            return
        }
        switch colorScheme {
        case .dark:
            setWindowUserInterfaceStyle(.dark)
        case .light:
            setWindowUserInterfaceStyle(.light)
        }
    }
    
    private func setWindowUserInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        allWindows()
            .forEach {
                $0.overrideUserInterfaceStyle = userInterfaceStyle
            }
    }
    
    private func setWindowTint(_ color: Color) {
        allWindows()
            .forEach {
                $0.tintColor = UIColor(color)
            }
    }
    
    private func setBarsColor(_ color: Color) {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barTintColor = UIColor(color)
    }
    
    private func allWindows() -> [UIWindow] {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
    }
#endif
}
