//
//  EmojiDescView.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/8.
//

import SwiftUI
public struct EmojiDescView: View {

    @EnvironmentObject private var theme: Theme

    // 直接使用String和LocalizedStringKey类型的属性
    public var emoji: String
    public var title: LocalizedStringKey
    public var desc: LocalizedStringKey?

    // 按钮文字和动作闭包，提供默认值为nil
    let buttonLabel: LocalizedStringKey?
    let action: (() -> Void)?

    public init(emoji: String = "📭️",
                title: LocalizedStringKey = "trans.No entries found",
                desc: LocalizedStringKey? = nil,
                buttonLabel: LocalizedStringKey? = nil,
                action: (() -> Void)? = nil) {
        self.emoji = emoji
        self.title = title
        self.desc = desc
        self.buttonLabel = buttonLabel
        self.action = action
    }

    public var body: some View {
        VStack {
            VStack(spacing: 2) {
                Text(emoji)
                    .font(.system(size: 50))
                    .padding(.bottom, 10)
                Text(title)
                    .font(.themeTitle3)
                    .fontWeight(.medium)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    .foregroundColor(.themeSecondaryText)

                if let desc {
                    Text(desc)
                        .font(.themeSubheadline).fontWeight(.thin)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        .foregroundColor(.themeSecondaryText)
                }
            }
            .frame(alignment: .center)

            // 添加按钮，只有在buttonLabel和action都不为空时才显示
            if let buttonLabel = buttonLabel, let action = action {
                Button(action: action) {
                    Text(buttonLabel)
                        .font(.themeTitle3).fontWeight(.regular)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        .foregroundColor(.themeTint)
                        .padding([.leading, .trailing], 40)
                }
                .padding(.top, 2)
            }
        }
        .frame(maxHeight: .infinity)
    }
}
