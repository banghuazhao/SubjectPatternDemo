//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
  

import Foundation
import Combine

final class NetworkService {    
    func fetch(from url: URL) -> AnyPublisher<String, URLError> {
        URLSession.shared
            .myDataTaskPublisher(for: url)
            .map { data, _ in String(data: data, encoding: .utf8) ?? "" }
            .eraseToAnyPublisher()
    }
}

