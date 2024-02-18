//
//  TextEditorWithPlaceholder.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/23.
//

import SwiftUI

public struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    var height: CGFloat = 60

    public init(text: Binding<String>, placeholder: LocalizedStringKey, height: CGFloat = 60) {
        self._text = text
        self.placeholder = placeholder
        self.height = height
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text(placeholder)
                        .font(.themeCallout)
                        .padding(.top, 10)
                        .padding(.leading, 6)
                        .opacity(0.6)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $text)
                    .font(.themeCallout)
                    .frame(height: height)
                    .opacity(text.isEmpty ? 0.6 : 1)
                Spacer()
            }
        }
    }
}

#Preview {
    TextEditorWithPlaceholder(text: .constant("Good"), placeholder: "text.short description")
}
