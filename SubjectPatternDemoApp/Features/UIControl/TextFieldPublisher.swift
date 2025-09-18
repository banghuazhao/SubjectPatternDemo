//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
//
//
import Combine
import Foundation
import SwiftUI
import UIKit

/// A UIViewRepresentable that sends editingChanged events to an external PassthroughSubject
struct TextFieldWithPublisher: UIViewRepresentable {
    let subject: PassthroughSubject<String, Never>

    final class Coordinator: NSObject, UITextFieldDelegate {
        let subject: PassthroughSubject<String, Never>
        init(subject: PassthroughSubject<String, Never>) { self.subject = subject }
        @objc func editingChanged(_ textField: UITextField) {
            subject.send(textField.text ?? "")
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(subject: subject) }

    func makeUIView(context: Context) -> UITextField {
        let tf = UITextField(frame: .zero)
        tf.borderStyle = .roundedRect
        tf.addTarget(context.coordinator, action: #selector(Coordinator.editingChanged(_:)), for: .editingChanged)
        return tf
    }

    func updateUIView(_ uiView: UITextField, context: Context) {}
}
