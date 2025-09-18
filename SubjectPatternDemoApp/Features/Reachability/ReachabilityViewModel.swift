//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
//  
//
import Foundation
import Combine
import Network

@MainActor
final class ReachabilityViewModel: ObservableObject {
    @Published var statusText: String = "Unknown"

    private let service = ReachabilityService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        service.publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .satisfied: self?.statusText = "Online"
                case .unsatisfied: self?.statusText = "Offline"
                case .requiresConnection: self?.statusText = "Requires Connection"
                @unknown default: self?.statusText = "Unknown"
                }
            }
            .store(in: &cancellables)
    }

    func start() { service.start() }
    func stop() { service.stop() }
}


