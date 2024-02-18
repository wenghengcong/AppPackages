//
//  HCTagForm.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/23.
//

import SwiftUI

/// 标签编辑字段
@available(macOS 11.0, *)
@available(iOS 14.0, *)
public struct HCTagForm: View {
    /* 绑定 */
    @Binding private var tagInfoList: [HCTagInfo]
    /* 变量 */
    private var placeholder: LocalizedStringKey = ""
    private var tagColer: Color = .black
    private var textColor: Color = .white
    @State private var inputLabel = ""
    
    /* 初始化 */
    public init(tagInfoList: Binding<[HCTagInfo]>,
         placeholder: LocalizedStringKey = "text.Input tags...",
         tagColer: Color = .black,
         textColor: Color = .white ) {
        self._tagInfoList = tagInfoList
        self.placeholder = placeholder
        self.tagColer = tagColer
        self.textColor = textColor
    }
    
    /* 主体 */
    public var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tagInfoList) { tag in
                        HCTagView(tagInfo: tag, textColor: textColor, onDelete: {
                            deleteTag(tag: tag)
                        })
                    }
                    
                    TextField(placeholder, text: $inputLabel, onCommit: {
                        /* Enter确认后的处理 */
                        DispatchQueue.main.async {
                              appendTag(label: inputLabel)
                              inputLabel = ""
                          }
                    })
                    .id("TextField")
                    .textFieldStyle(.plain)
                    .onChange(of: inputLabel) { change in
                        withAnimation {
                            scrollView.scrollTo("TextField", anchor: .trailing)
                        }
                    }
                }
            }
            .animation(.spring(), value: tagInfoList.count)
        }
    }
    
    /// 添加标签
    /// - Parameter label: 标签显示文字
    private func appendTag(label: String) {
        if label != "" {
            if tagInfoList.contains(where: {$0.label == label}) == false {
                tagInfoList.append(.init(id: UUID(), label: label, color: tagColer))
            }
        }
        inputLabel = ""
    }
    
    /// 删除标签
    /// - Parameter tag: 标签信息
    private func deleteTag(tag: HCTagInfo) {
        tagInfoList.removeAll(where: {$0.id == tag.id})
    }
}

/// 标签
@available(macOS 11.0, *)
@available(iOS 14.0, *)
public struct HCTagView: View {
    @ObservedObject public var tagInfo: HCTagInfo
    public var textColor: Color = .white
    public var onDelete: (() -> Void)? = nil

    public var body: some View {
        ZStack {
            HStack {
                Text(tagInfo.label)
                    .font(.headline).bold()
                    .foregroundColor(textColor)
                Button(action: {
                    self.onDelete?()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(textColor)
                }
                .buttonStyle(.plain)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5))
            .background(tagInfo.color)
            .clipShape(Capsule())
        }
    }
}

/// 标签信息类
@available(macOS 11.0, *)
@available(iOS 14.0, *)
public class HCTagInfo: ObservableObject, Identifiable {
    @Published public var id: UUID = UUID()
    @Published public var label: String = ""
    @Published public var color: Color = Color.blue
    
    public init(label: String){
        self.label = label
    }
    
    public init(label: String, color: Color){
        self.label = label
        self.color = color
    }
    
    public init(id: UUID, label: String, color: Color){
        self.id = id
        self.label = label
        self.color = color
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, label, color
    }
    
    public static func == (lhs: HCTagInfo, rhs: HCTagInfo) -> Bool {
        return lhs.id == rhs.id
    }
}

/// 预览：标签编辑字段
@available(macOS 11.0, *)
@available(iOS 14.0, *)
#Preview {
    @State var tagInfoList: [HCTagInfo] = [.init(label: "工作", color: .red),
                                                .init(label: "学校", color: .orange),
                                                .init(label: "私人", color: .yellow)]
    return VStack {
        HCTagForm(tagInfoList: $tagInfoList, placeholder: "在这里输入...", tagColer: .black)
    }
}
