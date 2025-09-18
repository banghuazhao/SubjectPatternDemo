//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
  
import SwiftUI
import Combine

final class CounterViewModel: ObservableObject {
    @MyPublished var count = 0
    
    func increment() {
        count += 1
    }
}
