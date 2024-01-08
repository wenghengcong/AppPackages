import Combine
import SwiftUI

public struct ThemePreviewView: View {
    private let gutterSpace: Double = 8
    @EnvironmentObject private var theme: Theme
    @Environment(\.dismiss) var dismiss

    public init() {}

    public var body: some View {
        ScrollView {
            ForEach(availableThemeSets) { couple in
                HStack(spacing: gutterSpace) {
                    ThemeBoxView(color: couple.light)
                    ThemeBoxView(color: couple.dark)
                }
            }
        }
        .padding(4)
        .frame(maxHeight: .infinity)
        .themeBackColor()
        .navigationTitle("design.theme.navigation-title")
    }
}

struct ThemeBoxView: View {
    @EnvironmentObject var theme: Theme
    private let gutterSpace = 8.0
    @State private var isSelected = false

    var color: ThemeSet

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(4)
                .shadow(radius: 2, x: 2, y: 4)
                .accessibilityHidden(true)

            VStack(spacing: gutterSpace) {
                Text(color.name.rawValue)
                    .foregroundColor(.themeTint)
                    .font(.system(size: 20))
                    .fontWeight(.bold)

                Text("design.theme.toots-preview")
                    .foregroundColor(theme.color(.brandBackground))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .themeBackColor()

                Text("#icecube, #techhub")
                    .foregroundColor(.themeTint)
                if isSelected {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.green)
                    }
                } else {
                    HStack {
                        Spacer()
                        Circle()
                            .strokeBorder(Color.themeTint, lineWidth: 1)
                            .background(Circle().fill(theme.color(.background)))
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(theme.color(.foreground))
            .font(.system(size: 15))
            .cornerRadius(4)
        }
        .onAppear {
            isSelected = theme.selectedTheme.rawValue == color.name.rawValue
        }
        .onChange(of: theme.selectedTheme) { newValue in
            isSelected = newValue.rawValue == color.name.rawValue
        }
        .onTapGesture {
            let currentScheme = theme.selectedScheme
            if color.scheme != currentScheme {
                theme.followSystemColorScheme = false
            }
            theme.selectedTheme = color.name
        }
    }
}
