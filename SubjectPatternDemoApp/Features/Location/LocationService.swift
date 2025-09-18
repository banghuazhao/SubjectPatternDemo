//
// Created by Banghua Zhao on 18/09/2025
// Copyright Apps Bay Limited. All rights reserved.
//
  

import Foundation
import Combine
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let subject = PassthroughSubject<CLLocation, Never>()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    var publisher: AnyPublisher<CLLocation, Never> {
        subject.eraseToAnyPublisher()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            subject.send(loc)
        }
    }
}
