//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
//  
//
import Foundation
import Combine
import UIKit

@MainActor
final class DisplayLinkViewModel: ObservableObject {
    @Published var frameCount: Int = 0
    @Published var isRunning: Bool = false

    private let service = DisplayLinkService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        service.publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.frameCount += 1
            }
            .store(in: &cancellables)
    }

    func start() {
        guard !isRunning else { return }
        isRunning = true
        service.start()
    }

    func stop() {
        guard isRunning else { return }
        isRunning = false
        service.stop()
    }
}


