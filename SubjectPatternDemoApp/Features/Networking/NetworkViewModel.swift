//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Combine
import Foundation

@MainActor
final class NetworkViewModel: ObservableObject {
    @Published var result: String?

    private let service = NetworkService()
    private var cancellables = Set<AnyCancellable>()

    func fetch() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }

        service.fetch(from: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] text in
                      self?.result = text
                  })
            .store(in: &cancellables)
    }
}
