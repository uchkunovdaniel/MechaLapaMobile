import SwiftUI

struct OverlayView: View {
    @ObservedObject var model: OverlayModel

    var body: some View {
        ZStack(alignment: .bottom) {
            // Transparent container to allow taps to pass through if needed
            Color.clear
                .contentShape(Rectangle())
                .allowsHitTesting(false)

            VStack(spacing: 8) {
                if !model.messageFromWeb.isEmpty {
                    Group {
                        if #available(iOS 15.0, *) {
                            Text("Web says: \(model.messageFromWeb)")
                                .font(.callout)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 2)
                        } else {
                            Text("Web says: \(model.messageFromWeb)")
                                .font(.callout)
                                .padding(10)
                                .background(Color(.systemBackground).opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 2)
                        }
                    }
                }

                Group {
                    if #available(iOS 15.0, *) {
                        HStack(spacing: 12) {
                            Button(action: { model.counter -= 1 }) {
                                Image(systemName: "minus.circle.fill")
                            }
                            Text("Counter: \(model.counter)")
                                .font(.headline)
                                .monospacedDigit()
                            Button(action: { model.counter += 1 }) {
                                Image(systemName: "plus.circle.fill")
                            }

                            Button("Send to Web") {
                                // Post a custom DOM event that your web app can listen for
                                let payload = [
                                    "counter": model.counter,
                                    "timestamp": Date().timeIntervalSince1970
                                ] as [String : Any]
                                // Use NotificationCenter to ask AppDelegate to forward to web
                                NotificationCenter.default.post(name: .sendToWeb, object: nil, userInfo: payload)
                            }
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 3)
                    } else {
                        HStack(spacing: 12) {
                            Button(action: { model.counter -= 1 }) {
                                Image(systemName: "minus.circle.fill")
                            }
                            Text("Counter: \(model.counter)")
                                .font(.headline)
                            Button(action: { model.counter += 1 }) {
                                Image(systemName: "plus.circle.fill")
                            }

                            Button("Send to Web") {
                                // Post a custom DOM event that your web app can listen for
                                let payload = [
                                    "counter": model.counter,
                                    "timestamp": Date().timeIntervalSince1970
                                ] as [String : Any]
                                // Use NotificationCenter to ask AppDelegate to forward to web
                                NotificationCenter.default.post(name: .sendToWeb, object: nil, userInfo: payload)
                            }
                        }
                        .padding(12)
                        .background(Color(.systemBackground).opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 3)
                    }
                }
            }
            .padding()
        }
    }
}

extension Notification.Name {
    static let sendToWeb = Notification.Name("OverlayView.sendToWeb")
}

#Preview {
    OverlayView(model: OverlayModel())
}
