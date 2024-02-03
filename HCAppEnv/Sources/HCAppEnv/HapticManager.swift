import CoreHaptics
import HCUtilKit
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


@MainActor
public class HapticManager {
    public static let shared: HapticManager = .init()
    
    public enum HapticType {
        case buttonPress
        case dataRefresh(intensity: CGFloat)
#if !os(macOS)
        case notification(_ type: UINotificationFeedbackGenerator.FeedbackType)
#endif
        case tabSelection
        case timeline
    }
    
#if !os(macOS)

    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private let notificationGenerator = UINotificationFeedbackGenerator()
    
#endif

    private let userPreferences = UserPreferences.shared
    private init() {
#if !os(macOS)
        selectionGenerator.prepare()
        impactGenerator.prepare()
#endif

    }
    

    public var supportsHaptics: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
    
    @MainActor
    public func fireHaptic(of type: HapticType) {
        guard supportsHaptics else { return }
#if !os(macOS)
        switch type {
        case .buttonPress:
            if userPreferences.hapticButtonPressEnabled {
                impactGenerator.impactOccurred()
            }
        case let .dataRefresh(intensity):
            if userPreferences.hapticTimelineEnabled {
                impactGenerator.impactOccurred(intensity: intensity)
            }
        case let .notification(type):
            if userPreferences.hapticButtonPressEnabled {
                notificationGenerator.notificationOccurred(type)
            }
        case .tabSelection:
            if userPreferences.hapticTabSelectionEnabled {
                selectionGenerator.selectionChanged()
            }
        case .timeline:
            if userPreferences.hapticTimelineEnabled {
                selectionGenerator.selectionChanged()
            }
        }
#endif
        
    }
}
