//
//  HCControlTokenSet.swift
//  
//
//  Created by Nemo on 2023/12/21.
//

import Foundation
import Combine
import SwiftUI

/// Base class for all Fluent control tokenization.
public class HCControlTokenSet<T: HCTokenSetKey>: ObservableObject {
    /// Allows us to index into this token set using square brackets.
    ///
    /// We can use square brackets to both read and write into this `HCTokenSet`. For example:
    /// ```
    /// let value = tokenSet[.primary]   // exercises the `get`
    /// tokenSet[.secondary] = newValue  // exercises the `set`
    /// ```
    public subscript(token: T) -> HCControlTokenValue {
        get {
            if let value = overrideValue(forToken: token) {
                return value
            } else if let value = defaults?(token, self.fluentTheme) {
                return value
            } else {
                preconditionFailure()
            }
        }
        set(value) {
            setOverrideValue(value, forToken: token)
        }
    }

    /// Removes a stored override for a given token value.
    ///
    /// - Parameter token: The token value whose override should be removed.
    public func removeOverride(_ token: T) {
        valueOverrides?[token] = nil
    }

    /// Convenience method to replace all overrides with a new set of values.
    ///
    /// Any value present in `overrideTokens` will be set onto this control. All other values will be
    /// removed from this control. If overrideTokens is `nil`, then all current overrides will be removed.
    ///
    /// - Parameter overrideTokens: The set of tokens to set as custom, or `nil` to remove all overrides.
    public func replaceAllOverrides(with overrideTokens: [T: HCControlTokenValue]?) {
        T.allCases.forEach { token in
            if let value = overrideTokens?[token] {
                self[token] = value
            } else {
                self.removeOverride(token)
            }
        }
    }

    /// Convenience method to override multiple tokens from another token set.
    ///
    /// This is useful if `otherTokenSet` belongs to a parent control and `self` belongs to a child control.
    ///
    /// - Parameter otherTokenSet: The token set we will be pulling values from.
    /// - Parameter mapping: A `Dictionary` that maps our own tokens that we wish to override with
    /// their corresponding tokens in `otherTokenSet`.
    func setOverrides<U>(from otherTokenSet: HCControlTokenSet<U>, mapping: [T: U]) {
        // Make a copy so we write all the values at once
        var valueOverrideCopy = valueOverrides ?? [:]
        mapping.forEach { (thisToken, otherToken) in
            valueOverrideCopy[thisToken] = otherTokenSet.overrideValue(forToken: otherToken)
        }
        valueOverrides = valueOverrideCopy
    }

    /// Initialize the `HCControlTokenSet` with an escaping callback for fetching default values.
    init(_ defaults: @escaping (_ token: T, _ theme: Theme) -> HCControlTokenValue) {
        self.defaults = defaults
    }

    deinit {
        deregisterOnUpdate()
    }

    /// Removes all `onUpdate`-based observing. Useful if you are re-registering the same tokenSet
    /// for a new instance of a control (see `Tooltip` for an example).
    func deregisterOnUpdate() {
        if let notificationObserver {
            NotificationCenter.default.removeObserver(notificationObserver,
                                                      name: .didChangeTheme,
                                                      object: nil)
        }
        changeSink = nil
        notificationObserver = nil
        onUpdate = nil
    }

    /// Prepares this token set by installing the current `FluentTheme` if it has changed.
    ///
    /// - Parameter fluentTheme: The current `FluentTheme` for the control's environment.
    func update(_ fluentTheme: Theme) {
        if fluentTheme != self.fluentTheme {
            self.fluentTheme = fluentTheme
        }
    }

    // Internal accessor and setter functions for the override dictionary

    /// Returns the current override value for a given token, or nil if none exists.
    ///
    /// This API will check `valueOverrides` first for local overrides, and `fluentTheme.tokens(for:)`
    /// second, returning the first of those to be non-nil, or nil if both are unset.
    ///
    /// - Parameter token: The token key to fetch any existing override for.
    ///
    /// - Returns: the active override value for a given token, or nil if none exists.
    func overrideValue(forToken token: T) -> HCControlTokenValue? {
        if let value = valueOverrides?[token] {
            return value
        } else if let value = fluentTheme.tokens(for: type(of: self))?[token] {
            return value
        }
        return nil
    }

    /// Sets an override value for a given token key.
    ///
    /// - Parameter value: The value to set as an override.
    /// - Parameter token: The token key whose value should be set.
    func setOverrideValue(_ value: HCControlTokenValue?, forToken token: T) {
        if valueOverrides == nil {
            valueOverrides = [:]
        }
        valueOverrides?[token] = value
    }

    /// Registers an observing control for update calls.
    ///
    /// The `onUpdate` callback will be invoked in two cases:
    /// 1. A new override value has been set on this `HCControlTokenSet`.
    /// 2. A `Notification.Name.didChangeTheme` notification was fired for either `control` or one of its superviews.
    ///
    /// Note: consecutive calls to this method will no-op; only the first invocation will be recognized. If you need to change
    /// the view requesting updates, invoke `deregisterOnUpdate()` before calling `registerOnUpdate` a second time.
    ///
    /// - Parameter control: The `UIView` instance that wishes to observe.
    /// - Parameter onUpdate: A callback to run whenever `control` should update itself.
    func registerOnUpdate(for control: UIView, onUpdate: @escaping (() -> Void)) {
        guard self.onUpdate == nil,
              changeSink == nil,
              notificationObserver == nil else {
            assertionFailure("Attempting to double-register for tokenSet updates!")
            return
        }
        self.onUpdate = onUpdate

        changeSink = self.objectWillChange.sink { [weak self] in
            // Values will be updated on the next run loop iteration.
            DispatchQueue.main.async {
                self?.onUpdate?()
            }
        }

        // Register for notifications in order to call update() when the theme changes.
        notificationObserver = NotificationCenter.default.addObserver(forName: .didChangeTheme,
                                                                      object: nil,
                                                                      queue: nil) { [weak self, weak control] notification in
            guard let strongSelf = self else {
                return
            }
            strongSelf.update(Theme.shared)
        }
    }

    /// The current `FluentTheme` associated with this `HCControlTokenSet`.
    var fluentTheme: Theme = Theme.shared {
        didSet {
            guard let onUpdate else {
                return
            }
            onUpdate()
        }
    }

    /// Access to raw overrides for the `HCControlTokenSet`.
    @Published private var valueOverrides: [T: HCControlTokenValue]?

    /// Reference to the default value lookup function for this control.
    private var defaults: ((_ token: T, _ theme: Theme) -> HCControlTokenValue)?

    /// Holds the sink for any changes to the control token set.
    private var changeSink: AnyCancellable?

    /// Stores the notification handler for .didChangeTheme notifications.
    private var notificationObserver: NSObjectProtocol?

    /// A callback to be invoked after the token set has completed updating.
    private var onUpdate: (() -> Void)?

    /// Common approach for addressing the tokens of a given control.
    public typealias Tokens = T
}

/// Union-type enumeration of all possible token values to be stored by a `HCControlTokenSet`.
public enum HCControlTokenValue {
    case float(() -> CGFloat)
    case color(() -> Color)
    case font(() -> Font)
    case shadowInfo(() -> HCShadowInfo)

    public var float: CGFloat {
        if case .float(let float) = self {
            return float()
        } else {
            assertionFailure("Cannot convert token to CGFloat: \(self)")
            return 0.0
        }
    }

    public var color: Color {
        if case .color(let color) = self {
            return color()
        } else {
            assertionFailure("Cannot convert token to UIColor: \(self)")
            return fallbackColor
        }
    }

    public var font: Font {
        if case .font(let font) = self {
            return font()
        } else {
            assertionFailure("Cannot convert token to FontInfo: \(self)")
            return Font.init(UIFont())
        }
    }

    public var shadowInfo: HCShadowInfo {
        if case .shadowInfo(let shadowInfo) = self {
            return shadowInfo()
        } else {
            assertionFailure("Cannot convert token to HCShadowInfo: \(self)")
            return HCShadowInfo(keyColor: fallbackColor,
                              keyBlur: 10.0,
                              xKey: 10.0,
                              yKey: 10.0,
                              ambientColor: fallbackColor,
                              ambientBlur: 10.0,
                              xAmbient: 10.0,
                              yAmbient: 10.0)
        }
    }

    /// Creates a `HCControlTokenValue` from any supported object type.
    ///
    /// Mapping for types of `value` and the resulting `HCControlTokenValue`:
    ///
    /// | `value` instance type | `HCControlTokenValue` |
    /// |---|---|
    /// | `NSNumber`¹  | `.float` |
    /// | `UIColor` | `.uiColor` |
    /// | `UIFont` | `.uiFont` |
    /// | `HCShadowInfo` | `.shadowInfo` |
    /// | All other types | `nil` |
    ///
    /// ¹ Note that, because `value` must be an object type, floats must be passed as a wrapped `NSNumber`.
    ///
    /// - Parameter value: An object of one of the supported types for `HCControlTokenValue`.
    init?(_ value: AnyObject) {
        switch value {
        case let number as NSNumber:
            self = .float { CGFloat(number.doubleValue) }
        case let color as Color:
            self = .color { color }
        case let font as Font:
            self = .font { font }
        case let shadowInfo as HCShadowInfo:
            self = .shadowInfo { shadowInfo }
        default:
            return nil
        }
    }

    // MARK: - Helpers

    private var fallbackColor: Color {
#if DEBUG
        // Use our global "Hot Pink" in debug builds, to help identify unintentional conversions.
        return HCGlobalTokens.sharedColor(.hotPink, .primary)
#else
        return HCGlobalTokens.neutralColor(.black)
#endif
    }
}

#if DEBUG
extension HCControlTokenValue: CustomStringConvertible {
    /// Handy debug-only description for logging these values.
    public var description: String {
        switch self {
        case .float(let float):
            return "HCControlTokenValue.float: \(float())"
        case .color(let color):
            return "HCControlTokenValue.color: \(color())"
        case .font(let font):
            return "HCControlTokenValue.font: \(font())"
        case .shadowInfo(let shadowInfo):
            return "HCControlTokenValue.shadowInfo: \(shadowInfo())"
        }
    }
}
#endif // DEBUG
