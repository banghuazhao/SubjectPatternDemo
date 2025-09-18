//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
  

import Foundation
import Combine

@propertyWrapper
final class MyPublished<Value> {
    private let subject: CurrentValueSubject<Value, Never>
    // The objectWillChange from the ObservableObject that own this property
    private weak var objectWillChange: ObservableObjectPublisher?
    
    var wrappedValue: Value {
        get { subject.value }
        set {
            subject.send(newValue)
            objectWillChange?.send()
        }
    }
    
    var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    init(wrappedValue: Value) {
        self.subject = CurrentValueSubject(wrappedValue)
    }
    
    static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance observed: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, MyPublished<Value>>
    ) -> Value {
        get {
            observed[keyPath: storageKeyPath].objectWillChange = observed.objectWillChange as? ObservableObjectPublisher
            return observed[keyPath: storageKeyPath].wrappedValue
        }
        set {
            observed[keyPath: storageKeyPath].objectWillChange = observed.objectWillChange as? ObservableObjectPublisher
            observed[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }

}

