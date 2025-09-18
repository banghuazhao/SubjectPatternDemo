//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
//  
//
import Foundation
import Combine
import Network

/// Demonstrates bridging NWPathMonitor callbacks into a Combine publisher via PassthroughSubject
final class ReachabilityService {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityService.queue")
    private let subject = PassthroughSubject<NWPath.Status, Never>()

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.subject.send(path.status)
        }
    }

    func start() {
        monitor.start(queue: queue)
    }

    func stop() {
        monitor.cancel()
    }

    var publisher: AnyPublisher<NWPath.Status, Never> {
        subject.eraseToAnyPublisher()
    }
}


