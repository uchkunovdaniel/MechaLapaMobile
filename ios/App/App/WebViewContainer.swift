//
//  WebViewContainer.swift
//  App
//
//  Created by Daniel Uchkunov on 20.11.25.
//

import Foundation
import SwiftUI
import Capacitor

struct WebViewContainer: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        // Use Capacitor's view controller as the WebView container
        return CAPBridgeViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Nothing needed here
    }
}
