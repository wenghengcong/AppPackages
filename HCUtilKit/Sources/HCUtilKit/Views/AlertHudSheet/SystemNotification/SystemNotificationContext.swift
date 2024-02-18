//
//  SystemNotificationContext.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This context can be used to present system notifications in
 a more flexible way.
 
 To use this class, create a context instance and bind it to
 a view with the context-based `systemNotification` modifier.
 
 ```swift
 struct ContentView: View {
 
    @StateObject
    var context = SystemNotificationContext()
 
    var body: some View {
        TabView {
            ...
        }.systemNotification(context)
    }
 }
 ```
 
 You can now call the various `present` functions to present
 notifications using this single modifier, instead of having
 separate states and bindings for each notification.
 */
public class SystemNotificationContext: ObservableObject {

    public init() {}

    public typealias Action = () -> Void

    private var presentationId = UUID()


    @Published
    public var configuration = SystemNotificationConfiguration.standard

    @Published
    public var content = AnyView(EmptyView())

    @Published
    public var isActive = false

    @Published
    public var style = SystemNotificationStyle.standard


    @Published
    private var originalConfiguration: SystemNotificationConfiguration?

    @Published
    private var originalStyle: SystemNotificationStyle?


    public var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
    
    /// Dismiss the current notification, if any.
    public func dismiss() {
        dismiss {}
    }
        
    /// Dismiss the current notification, if any.
    public func dismiss(completion: @escaping Action) {
        guard isActive else { return completion() }
        isActive = false
        perform(after: 0.3, action: completion)
    }
    
    /// Present a system notification.
    public func present<Content: View>(
        content: Content,
        configuration: SystemNotificationConfiguration? = nil,
        style: SystemNotificationStyle? = nil
    ) {
        dismiss {
            self.presentAfterDismiss(
                content: content,
                configuration: configuration,
                style: style
            )
        }
    }
    
    /// Present a system notification.
    public func present<Content: View>(
        configuration: SystemNotificationConfiguration? = nil,
        style: SystemNotificationStyle? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        present(
            content: content(),
            configuration: configuration,
            style: style
        )
    }
}

private extension SystemNotificationContext {
    
    func perform(_ action: @escaping Action, after seconds: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: action)
    }
    
    func perform(after seconds: TimeInterval, action: @escaping Action) {
        perform(action, after: seconds)
    }
    
    func presentAfterDismiss<Content: View>(
        content: Content,
        configuration: SystemNotificationConfiguration?,
        style: SystemNotificationStyle?
    ) {
        let id = UUID()
        self.presentationId = id
        updateConfiguration(with: configuration)
        updateStyle(with: style)
        self.content = AnyView(content)
        perform(setActive, after: 0.1)
        perform(after: self.configuration.duration) {
            guard id == self.presentationId else { return }
            self.dismiss()
        }
    }
    
    func setActive() {
        isActive = true
    }

    func updateConfiguration(with config: SystemNotificationConfiguration?) {
        self.configuration = self.originalConfiguration ?? self.configuration
        self.originalConfiguration = self.configuration
        self.configuration = config ?? self.configuration
    }

    func updateStyle(with style: SystemNotificationStyle?) {
        self.style = self.originalStyle ?? self.style
        self.originalStyle = self.style
        self.style = style ?? self.style
    }
}
