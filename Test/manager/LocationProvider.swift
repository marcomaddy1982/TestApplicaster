//
//  LocationProvider.swift
//  Test
//
//  Created by Marco Maddalena on 10/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationProviderDelegate: NSObjectProtocol {
    func locationProvider(provider:LocationProvider, didUpdateLatidude latitude:String, longitude:String)
    func locationProviderDidDainedAuthorization(provider:LocationProvider)
    func locationProvider(provider:LocationProvider, didFailWithError error: Error)
}

class LocationProvider: NSObject, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    weak var delegate: LocationProviderDelegate?
    
    // MARK: lifecycle
    
    init(delegate: LocationProviderDelegate?) {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        self.delegate = delegate
    }
    
    // MARK: public implementation
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    // MARK: private implementation
    private func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
        self.locationManager = nil
    }
    
    // MARK: LocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.stopUpdatingLocation()
        let currentLocation = locations[0]
        let userLat = String(format: "%f", currentLocation.coordinate.latitude)
        let userLong = String(format: "%f", currentLocation.coordinate.longitude)
//        print("lat: %@, lng:%@", userLat, userLong)
        self.delegate?.locationProvider(provider: self, didUpdateLatidude: userLat, longitude: userLong)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.locationProvider(provider: self, didFailWithError: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined,
             .restricted,
             .denied,
             .authorizedAlways:
            self.delegate?.locationProviderDidDainedAuthorization(provider: self)
            
        case .authorizedWhenInUse:
            self.startUpdatingLocation()
        }
    }
}
