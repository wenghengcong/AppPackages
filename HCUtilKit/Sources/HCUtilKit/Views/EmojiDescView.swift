//
//  EmojiDescView.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/8.
//

import SwiftUI

public struct EmojiDescView: View {
    
    @EnvironmentObject private var theme: Theme

    @State public var emoji = "📭️"
    @State public var title: LocalizedStringKey = "trans.No entries found"
    @State public var desc: LocalizedStringKey = "trans.Memo now!"

    public init(emoji: String = "📭️", 
                title: LocalizedStringKey = "trans.No entries found",
                desc: LocalizedStringKey = "trans.Memo now!") {
        self._emoji = State(initialValue: emoji)
        self._title = State(initialValue: title)
        self._desc = State(initialValue: desc)
    }

    public var body: some View {
        VStack {
            VStack(spacing: 2) {
                Text(emoji)
                    .font(.system(size: 50))
                    .padding(.bottom, 15)
                Text(title)
                    .font(.themeTitle3)
                    .fontWeight(.medium)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    .foregroundColor(.themeSecondaryText)

                Text(desc)
                    .font(.themeSubheadline).fontWeight(.regular)
                    .font(.system(.subheadline, design: .rounded).weight(.regular))
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    .foregroundColor(.themeTertiaryText)
            }
            .frame(alignment: .center)
//            .opacity(0.8)
        }
        .frame(maxHeight: .infinity)
    }
}
