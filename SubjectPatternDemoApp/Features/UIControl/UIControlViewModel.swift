//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
  

import SwiftUI
import Combine

@MainActor
final class UIControlViewModel: ObservableObject {
    @Published var text: String = ""
    let inputSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        inputSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.text = value
            }
            .store(in: &cancellables)
    }
}
