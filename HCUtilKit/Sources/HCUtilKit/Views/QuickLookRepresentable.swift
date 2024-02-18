//
//  QuickLookRepresentable.swift
//  Sunshine
//
//  Created by Nemo on 2023/10/24.
//

import QuickLook
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension URL: Identifiable {
    public var id: String {
        absoluteString
    }
}

#if os(macOS)
#else

public struct QuickLookPreview: UIViewControllerRepresentable {
    let selectedURL: URL
    let urls: [URL]
    
    public init(selectedURL: URL, urls: [URL]) {
        self.selectedURL = selectedURL
        self.urls = urls
    }

    public func makeUIViewController(context _: Context) -> UIViewController {
        AppQLPreviewController(selectedURL: selectedURL, urls: urls)
    }
    
    public func updateUIViewController(
        _: UIViewController, context _: Context
    ) {}
}

@MainActor
public class AppQLPreviewController: UIViewController {
    let selectedURL: URL
    let urls: [URL]
    
    var qlController: QLPreviewController?
    
    public init(selectedURL: URL, urls: [URL]) {
        self.selectedURL = selectedURL
        self.urls = urls
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if qlController == nil {
            qlController = QLPreviewController()
            qlController?.dataSource = self
            qlController?.delegate = self
            qlController?.currentPreviewItemIndex = urls.firstIndex(of: selectedURL) ?? 0
            present(qlController!, animated: true)
        }
    }
}


extension AppQLPreviewController: QLPreviewControllerDataSource {
    nonisolated public func numberOfPreviewItems(in _: QLPreviewController) -> Int {
        urls.count
    }
    
    nonisolated public func previewController(_: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        urls[index] as QLPreviewItem
    }
}

extension AppQLPreviewController: QLPreviewControllerDelegate {
    nonisolated public func previewController(_: QLPreviewController, editingModeFor _: QLPreviewItem) -> QLPreviewItemEditingMode {
        .createCopy
    }
    
    nonisolated public func previewControllerWillDismiss(_: QLPreviewController) {
        Task { @MainActor in
            dismiss(animated: true)
        }
    }
    
    nonisolated public func previewControllerDidDismiss(_: QLPreviewController) {
        Task { @MainActor in
            dismiss(animated: true)
        }
    }
}

public struct TransparentBackground: UIViewControllerRepresentable {

    public init() {

    }

    public func makeUIViewController(context _: Context) -> UIViewController {
        TransparentController()
    }
    
    public func updateUIViewController(_: UIViewController, context _: Context) {}
    
    public class TransparentController: UIViewController {
        public init() {
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
        }
        
        public override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            parent?.view?.backgroundColor = .clear
            parent?.modalPresentationStyle = .overCurrentContext
        }
    }
}

#endif
