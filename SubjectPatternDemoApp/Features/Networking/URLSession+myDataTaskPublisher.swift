//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Combine
import Foundation

extension URLSession {
    func myDataTaskPublisher(for url: URL) -> AnyPublisher<(Data, URLResponse), URLError> {
        let subject = PassthroughSubject<(Data, URLResponse), URLError>()

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                subject.send(completion: .failure(error))
                return
            }
            guard let data = data, let response = response else {
                subject.send(completion: .failure(URLError(.badServerResponse)))
                return
            }
            subject.send((data, response))
            subject.send(completion: .finished)
        }.resume()

        return subject.eraseToAnyPublisher()
    }
}
