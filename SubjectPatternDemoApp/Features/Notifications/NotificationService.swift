//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
//  
//
import Foundation
import Combine

/// Demonstrates bridging NotificationCenter callbacks into a Combine publisher via PassthroughSubject
final class NotificationService {
    struct Names {
        static let demoNotification = Notification.Name("NotificationService.demoNotification")
    }

    private let subject = PassthroughSubject<Notification, Never>()
    private var observer: NSObjectProtocol?

    init(center: NotificationCenter = .default) {
        observer = center.addObserver(forName: Names.demoNotification, object: nil, queue: .main) { [weak self] notification in
            self?.subject.send(notification)
        }
    }

    deinit {
        if let observer { NotificationCenter.default.removeObserver(observer) }
    }

    /// Exposes the bridged notifications
    var publisher: AnyPublisher<Notification, Never> {
        subject.eraseToAnyPublisher()
    }

    /// Helper to emit a demo notification (simulates an external event source)
    func postDemoEvent(payload: String) {
        NotificationCenter.default.post(name: Names.demoNotification, object: nil, userInfo: ["payload": payload])
    }
}


