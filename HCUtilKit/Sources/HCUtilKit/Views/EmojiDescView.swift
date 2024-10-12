//
//  EmojiDescView.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/8.
//

import SwiftUI

import SwiftUI

public struct EmojiDescView: View {
    
    @EnvironmentObject private var theme: Theme
    
    // 使用@Binding代替@State，如果这些值是由父视图提供的
    @Binding public var emoji: String
    @Binding public var title: LocalizedStringKey
    @Binding public var desc: LocalizedStringKey
    
    // 按钮文字和动作闭包，提供默认值为nil
    let buttonLabel: String?
    let action: (() -> Void)?

    public init(emoji: Binding<String> = .constant("📭️"),
                title: Binding<LocalizedStringKey> = .constant("trans.No entries found"),
                desc: Binding<LocalizedStringKey> = .constant("trans.Memo now!"),
                buttonLabel: String? = nil,
                action: (() -> Void)? = nil) {
        self._emoji = emoji
        self._title = title
        self._desc = desc
        self.buttonLabel = buttonLabel
        self.action = action
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

            // 添加按钮，只有在buttonLabel和action都不为空时才显示
            if let buttonLabel = buttonLabel, let action = action {
                Button(action: action) {
                    Text(buttonLabel)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
        }
        .frame(maxHeight: .infinity)
    }
}
