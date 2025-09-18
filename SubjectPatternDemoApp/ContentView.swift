//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
  

import SwiftUI

struct ContentView: View {
    @StateObject private var networkVM = NetworkViewModel()
    @StateObject private var locationVM = LocationViewModel()
    @StateObject private var counterVM = CounterViewModel()
    @StateObject private var notificationVM = NotificationViewModel()
    @StateObject private var displayLinkVM = DisplayLinkViewModel()
    @StateObject private var reachabilityVM = ReachabilityViewModel()
    @StateObject private var uiControlVM = UIControlViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("🌐 Network Request")) {
                    Button("Fetch Data") {
                        networkVM.fetch()
                    }
                    if let result = networkVM.result {
                        Text("Result: \(result)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("📍 Location Updates")) {
                    if let locationInfo = locationVM.locationInfo {
                        Text(locationInfo)
                            .font(.caption)
                    } else {
                        Text("No location yet")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Button("Request Location") {
                        locationVM.start()
                    }
                }
                
                Section(header: Text("🔢 Counter (@Published Demo)")) {
                    Text("Count: \(counterVM.count)")
                        .font(.headline)
                    Button("Increment") {
                        counterVM.increment()
                    }
                }

                Section(header: Text("🔔 NotificationCenter → Publisher")) {
                    HStack {
                        Text("Received: \(notificationVM.receivedCount)")
                        if let payload = notificationVM.lastPayload {
                            Text("(\(payload))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    Button("Send Demo Notification") {
                        notificationVM.sendDemo()
                    }
                }

                Section(header: Text("⏱️ CADisplayLink → Publisher")) {
                    Text("Frames: \(displayLinkVM.frameCount)")
                    HStack {
                        Button(displayLinkVM.isRunning ? "Running" : "Start") {
                            displayLinkVM.start()
                        }
                        .disabled(displayLinkVM.isRunning)
                        Button("Stop") {
                            displayLinkVM.stop()
                        }
                        .disabled(!displayLinkVM.isRunning)
                    }
                }

                Section(header: Text("📶 Reachability (NWPathMonitor) → Publisher")) {
                    Text("Status: \(reachabilityVM.statusText)")
                    HStack {
                        Button("Start Monitoring") { reachabilityVM.start() }
                        Button("Stop") { reachabilityVM.stop() }
                    }
                }

                Section(header: Text("⌨️ UIControl (UITextField) → Publisher")) {
                    TextFieldWithPublisher(subject: uiControlVM.inputSubject)
                        .frame(height: 36)
                    Text("Text: \(uiControlVM.text)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Subject Pattern Demo")
        }
    }
}

#Preview {
    ContentView()
}
