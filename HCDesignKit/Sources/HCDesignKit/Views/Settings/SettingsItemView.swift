//
//  SettingItemRow.swift
//  Sunshine
//
//  Created by Nemo on 2023/12/7.
//

import SwiftUI

public struct SettingsItemView: View {
    var icon: String?
    var color: Color?
    var title: LocalizedStringKey
    var rotation: Double = 0
    var chevronIcon: String?

    public var body: some View {
        HStack(spacing: 15) {
            if let icon {
                ZStack {
                    Image(systemName: icon)
                        .rotationEffect(.degrees(rotation))
                        .font(.body)
                        .foregroundColor(color == .white ? .blue : .white)
                }
                .frame(width: 28, height: 28)
                .background(color)
                .cornerRadius(6)
                .shadow(radius: 0.5)
            }
           
            Text(title)
                .foregroundColor(.primary)

            if let chevron = chevronIcon {
                Spacer()
                Image(systemName: chevron)
                    .font(Font.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .contentShape(Rectangle())
        /// Spacer not working with onTapGesture
        /// workaround: https://stackoverflow.com/questions/57191013/swiftui-cant-tap-in-spacer-of-hstack
    }
}


#Preview {
    List {
        Section {
            SettingsItemView(
                icon: "lock.shield.fill",
                color: .blue,
                title: "Privacy Policy",
                chevronIcon: "arrow.up.right")
        }
    }
}
