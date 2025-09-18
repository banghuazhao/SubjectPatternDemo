//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
//  
//
import Foundation
import Combine

@MainActor
final class NotificationViewModel: ObservableObject {
    @Published var lastPayload: String?
    @Published var receivedCount: Int = 0

    private let service = NotificationService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        service.publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                self?.receivedCount += 1
                if let payload = notification.userInfo?["payload"] as? String {
                    self?.lastPayload = payload
                }
            }
            .store(in: &cancellables)
    }

    func sendDemo() {
        service.postDemoEvent(payload: "Event #\(receivedCount + 1)")
    }
}


