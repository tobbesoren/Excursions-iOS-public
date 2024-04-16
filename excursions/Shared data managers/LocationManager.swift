//
//  LocationModel.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-20.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var isLocationAuthorized: Bool = false
    @Published var currentLocation: CLLocation?
    @Published var lastLocation: CLLocation?
    
    static let shared = LocationManager()

    override init() {
        print("LocationManager init")
        super.init()
        self.locationManager.delegate = self
        checkLocationAuthorization()
        print("Done init")
        print(self.isLocationAuthorized)
    }
    
    func distanceString(to location: Location) -> String? {
        guard let distance = distanceInMeters(to: location) else { return nil }
        return String(format: "%.2f", distance / 1000)
    }
    
    func distanceInMeters(to location: Location) -> Double? {
        guard let currentLocation else { return nil }
        let destinationLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        return (currentLocation.distance(from: destinationLocation) )
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        currentLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location failed with error:")
        print(error.localizedDescription)
    }
    
    func checkLocationAuthorization() {
        
        print("checkLocationAuth")
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationAuthorized = true
            locationManager.startUpdatingLocation()
            // Only request authorization if not already authorized
        case .denied, .restricted, .notDetermined:
            isLocationAuthorized = false
            self.locationManager.requestWhenInUseAuthorization()
        @unknown default:
            isLocationAuthorized = false
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
