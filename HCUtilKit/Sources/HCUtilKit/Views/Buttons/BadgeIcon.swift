//
//  BadgeIcon.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/16.
//

import SwiftUI

/// reference: https://github.com/danielsaidi/BadgeIcon
/**
 This view mimics the color badge icons that can be found in
 System Settings on iOS and macOS.
 */
public struct BadgeIcon: View {

    /**
     Create a badge icon.

     - Parameters:
       - icon: The image to use.
       - iconColor: The icon color, by default `semi-black` or `white`.
       - iconFill: The icon fill mode, by default `true`.
       - iconGradient: Whether or not to add a gradient to the icon color, by default `true`.
       - iconOffset: The icon offset, by default `.zero`.
       - iconPadding: The icon padding, by default calculated at runtime.
       - iconRenderingMode: The icon symbol rendering mode, by default `.monochrome`.
       - badgeColor: The badge color, by default `.white`.
       - badgeCornerRadius: The badge corner radius, by default calculated at runtime.
       - badgeGradient: Whether or not to add a gradient to the icon color, by default `true`.
       - badgeStrokeColor: The badge stroke color, if any.
       - badgeStrokeWidth: The badge stroke width, by default `1`.
     */
    public init(
        icon: Image,
        iconColor: Color? = nil,
        iconFill: Bool = true,
        iconGradient: Bool = true,
        iconOffset: CGPoint = .zero,
        iconPadding: Double? = nil,
        iconRenderingMode: SymbolRenderingMode = .monochrome,
        badgeColor: Color = .white,
        badgeCornerRadius: Double? = nil,
        badgeGradient: Bool = true,
        badgeStrokeColor: Color? = nil,
        badgeStrokeWidth: Double = 1
    ) {
        let whiteBadge = badgeColor == .white
        let whiteBadgeStroke = Color(hex: 0xe7e7e7)
        let whiteBadgeIconColor = Color.black.opacity(0.8)
        let defaultIconColor = Color.white
        let defaultStrokeColor = Color.clear
        let fallbackIconColor = whiteBadge ? whiteBadgeIconColor : defaultIconColor
        let fallbackStroke = whiteBadge ? whiteBadgeStroke : defaultStrokeColor

        self.icon = icon
        self.iconColor = iconColor ?? fallbackIconColor
        self.iconFill = iconFill
        self.iconGradient = iconGradient
        self.iconOffset = iconOffset
        self.iconPadding = iconPadding
        self.iconRenderingMode = iconRenderingMode
        self.badgeColor = badgeColor
        self.badgeCornerRadius = badgeCornerRadius
        self.badgeGradient = badgeGradient
        self.badgeStrokeColor = badgeStrokeColor ?? fallbackStroke
        self.badgeStrokeWidth = badgeStrokeWidth
    }

    public var icon: Image
    public var iconColor: Color?
    public var iconGradient: Bool
    public var iconFill: Bool
    public var iconOffset: CGPoint
    public var iconPadding: Double?
    public var iconRenderingMode: SymbolRenderingMode
    public var badgeColor: Color
    public var badgeCornerRadius: Double?
    public var badgeGradient: Bool
    public var badgeStrokeColor: Color
    public var badgeStrokeWidth: Double

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                badge(badgeColor, gradient: badgeGradient)
                    .cornerRadius(cornerRadius(for: geo))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius(for: geo))
                            .stroke(badgeStrokeColor, lineWidth: 1)
                    )
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        icon.resizable()
                            .aspectRatio(contentMode: .fit)
                            .symbolRenderingMode(iconRenderingMode)
                            .symbolVariant(iconFill ? .fill : .none)
                            .padding(iconPadding(for: geo))
                            .offset(x: iconOffset.x, y: iconOffset.y)
                            .foregroundColor(iconColor, gradientIf: iconGradient)
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

extension BadgeIcon {

    func cornerRadius(for geo: GeometryProxy) -> Double {
        badgeCornerRadius ?? 0.3 * geo.size.width
    }

    func iconPadding(for geo: GeometryProxy) -> Double {
        badgeCornerRadius ?? 0.17 * geo.size.width
    }
}

public extension BadgeIcon {

    static var alert = Self(
        icon: .symbol("exclamationmark.triangle"),
        iconColor: .orange
    )

    static var appStore = Self(
        icon: Image(systemName: "apple.logo"),
        iconColor: .white.opacity(0.6),
        badgeColor: .black.opacity(0.9)
    )

    static var bug = Self(
        icon: .symbol("ladybug"),
        iconRenderingMode: .multicolor
    )

    static var checkmark = Self(
        icon: .symbol("checkmark.circle"),
        iconColor: .green
    )

    static var email = Self(
        icon: .symbol("envelope"),
        iconColor: .white,
        badgeColor: .blue
    )

    static var error = Self(
        icon: .symbol("exclamationmark.triangle"),
        iconColor: .red
    )

    static var featureRequest = Self(
        icon: .symbol("gift"),
        iconColor: .pink
    )

    static var languageSettings = Self(
        icon: .symbol("globe"),
        iconColor: .cyan
    )

    static var lightbulb = Self(
        icon: .symbol("lightbulb"),
        iconColor: .yellow
    )

    static var palette = Self(
        icon: .symbol("paintpalette"),
        iconColor: nil,
        iconRenderingMode: .multicolor
    )

    static var person = Self(
        icon: .symbol("person")
    )

    static var privacy = Self(
        icon: .symbol("checkmark.shield.fill"),
        iconColor: .green
    )

    static func prominent(
        icon: Image,
        iconColor: Color = .white,
        iconPadding: Double = 6,
        badgeColor: Color
    ) -> Self {
        .init(
            icon: icon,
            iconColor: iconColor,
            iconPadding: iconPadding,
            badgeColor: badgeColor
        )
    }

    static var prominentAlert = prominent(
        icon: .symbol("exclamationmark.triangle"),
        badgeColor: .orange
    )

    static var prominentCheckmark = prominent(
        icon: .symbol("checkmark.circle"),
        badgeColor: .green
    )

    static var prominentError = prominent(
        icon: .symbol("exclamationmark.triangle"),
        badgeColor: .red
    )

    static var redHeart = Self(
        icon: .symbol("heart"),
        iconColor: .red
    )

    static var safari = Self(
        icon: .symbol("safari"),
        iconColor: .blue
    )

    static var share = Self(
        icon: .symbol("square.and.arrow.up"),
        iconFill: false,
        iconOffset: .init(x: 0, y: -1)
    )

    static var yellowStar = Self(
        icon: .symbol("star"),
        iconColor: .yellow
    )
}

private extension Color {

    func asGradientBackground() -> some View {
        Color.clear.overlay(self.gradient)
    }
}

private extension View {

    @ViewBuilder
    func badge(
        _ color: Color,
        gradient condition: Bool
    ) -> some View {
        if condition {
            color.overlay(color.gradient)
        } else {
            color
        }
    }

    @ViewBuilder
    func foregroundColor(
        _ color: Color?,
        gradientIf condition: Bool
    ) -> some View {
        if let color, condition {
            self.foregroundStyle(color.gradient)
        } else if let color {
            self.foregroundStyle(color)
        } else {
            self
        }
    }

    @ViewBuilder
    func withStrokeColor(
        _ color: Color
    ) -> some View {
        self.cornerRadius(7)
            .padding(0.6)
            .background(color.cornerRadius(7.6))
    }
}

@ViewBuilder
private func previewItems() -> some View {
    item(BadgeIcon.alert, "alert")
    item(BadgeIcon.appStore, "appStore")
    item(BadgeIcon.bug, "bug")
    item(BadgeIcon.checkmark, "checkmark")
    item(BadgeIcon.email, "email")
    item(BadgeIcon.error, "error")
    item(BadgeIcon.featureRequest, "featureRequest")
    item(BadgeIcon.languageSettings, "languageSettings")
    item(BadgeIcon.lightbulb, "lightbulb")
    item(BadgeIcon.palette, "multicolorPalette")
    item(BadgeIcon.person, "person")
    item(BadgeIcon.privacy, "privacy")
    item(BadgeIcon.prominentAlert, "prominentAlert")
    item(BadgeIcon.prominentCheckmark, "prominentCheckmark")
    item(BadgeIcon.prominentError, "prominentError")
    item(BadgeIcon.redHeart, "redHeart")
    item(BadgeIcon.safari, "safari")
    item(BadgeIcon.share, "share")
    item(BadgeIcon.yellowStar, "yellowStar")
}

//#Preview("List") {
//    List {
//        previewItems()
//    }
//    .previewDisplayName("List")
//}

#Preview("Grid") {

    struct Preview: View {

        var body: some View {
            ScrollView(.vertical) {
                LazyVGrid(columns: [.init(.adaptive(minimum: 40, maximum: 50))]) {
                    previewItems()
                }
                .padding()
            }
            .labelStyle(.iconOnly)
            .previewDisplayName("List")
        }
    }

    return Preview()
}

private func item<ViewType: View>(
    _ view: ViewType,
    _ name: String
) -> some View {
    Label(
        title: { Text(name) },
        icon: { view }
    )
}
