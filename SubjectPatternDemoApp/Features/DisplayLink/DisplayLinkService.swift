//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
//  
//
import Foundation
import Combine
import UIKit

/// Demonstrates bridging CADisplayLink callbacks into a Combine publisher via PassthroughSubject
final class DisplayLinkService {
    private var displayLink: CADisplayLink?
    private let subject = PassthroughSubject<CADisplayLink, Never>()

    func start() {
        guard displayLink == nil else { return }
        let link = CADisplayLink(target: self, selector: #selector(tick(_:)))
        link.add(to: .main, forMode: .common)
        displayLink = link
    }

    func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }

    var publisher: AnyPublisher<CADisplayLink, Never> {
        subject.eraseToAnyPublisher()
    }

    @objc private func tick(_ link: CADisplayLink) {
        subject.send(link)
    }
}


