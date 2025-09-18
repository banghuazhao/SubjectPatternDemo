//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
  

import Foundation
import Combine
import CoreLocation

@MainActor
final class LocationViewModel: ObservableObject {
    @Published var locationInfo: String?
    
    private let service = LocationService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        service.publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loc in
                self?.locationInfo = "Lat: \(loc.coordinate.latitude), Lon: \(loc.coordinate.longitude)"
            }
            .store(in: &cancellables)
    }
    
    func start() {
        service.start()
    }
}
