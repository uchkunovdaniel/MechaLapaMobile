import Foundation
import Capacitor

@objc(NativeBridgePlugin)
public class NativeBridgePlugin: CAPPlugin {

    private let implementation = NativeBridge()

    public override func load() {
        super.load()
        // Listen for overlay notifications and forward to web as events
        NotificationCenter.default.addObserver(self, selector: #selector(handleSendToWeb(_:)), name: .sendToWeb, object: nil)
    }

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func setMessage(_ call: CAPPluginCall) {
        let message = call.getString("message") ?? ""
        // Optionally store this somewhere; for demo we just notify SwiftUI via NotificationCenter
        NotificationCenter.default.post(name: .messageFromWeb, object: nil, userInfo: ["message": message])
        notifyListeners("message", data: ["message": message])
        call.resolve()
    }

    @objc private func handleSendToWeb(_ note: Notification) {
        var data: [String: Any] = [:]
        if let userInfo = note.userInfo as? [String: Any] {
            data = userInfo
        }
        notifyListeners("nativeEvent", data: data)
        // Also dispatch a DOM CustomEvent for apps not using Capacitor listeners directly
        bridge?.webView?.evaluateJavaScript("window.dispatchEvent(new CustomEvent('native-event', { detail: \(jsonString(data)) }))")
    }

    private func jsonString(_ obj: Any) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: obj, options: []),
              let str = String(data: data, encoding: .utf8) else { return "{}" }
        return str
    }
}

@objc(NativeBridge)
public class NativeBridge: NSObject {
    @objc public func echo(_ value: String) -> String {
        return value
    }
}

extension Notification.Name {
    static let messageFromWeb = Notification.Name("NativeBridgePlugin.messageFromWeb")
}
