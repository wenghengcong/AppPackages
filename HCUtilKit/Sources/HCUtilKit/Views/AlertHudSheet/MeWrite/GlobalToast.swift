//
//  TopNotificationView.swift
//  Sunshine
//
//  Created by Nemo on 2024/1/26.
//

import Foundation
import SwiftUI

public func g_toastInfo(_ context: SystemNotificationContext,
                        title: LocalizedStringKey? = nil,
                        text:LocalizedStringKey) {
    context.present {
        SystemNotificationMessage(
            icon: Image(systemName: "globe"),
            title: title,
            text: text)
    }
}

public func g_toastWarning(_ context: SystemNotificationContext,
                           title: LocalizedStringKey? = nil,
                           text:LocalizedStringKey) {
    context.present {
        SystemNotificationMessage(
            icon: Image(systemName: "exclamationmark.triangle"),
            title: title,
            text: text)
    }
}

public func g_toastError(_ context: SystemNotificationContext,
                         title: LocalizedStringKey? = nil,
                         text:LocalizedStringKey) {
    context.present {
        SystemNotificationMessage(
            icon: Image(systemName: "xmark.circle"),
            title: title,
            text: text)
    }
}

public func g_toastSuccessful(_ context: SystemNotificationContext,
                              title: LocalizedStringKey? = nil,
                              text:LocalizedStringKey) {
    let view = SystemNotificationMessage(
        icon: Image(systemName: "checkmark.circle"),
        title: title,
        text: text)

    let style = SystemNotificationStyle()
    context.present(content: view, style: style)
}
