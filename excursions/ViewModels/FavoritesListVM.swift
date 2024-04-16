//
//  File.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-14.
//

import SwiftUI
import Combine
import CoreLocation

class FavoritesListVM: ObservableObject {
    @Published var isEdit = false
    @Published var searchProfiles: SearchProfilesManager
    @ObservedObject var locationManager: LocationManager
    private var lastLocation: CLLocation?
    
    private var cancellable: AnyCancellable?
    
    private var places: [Place] {
        searchProfiles.selectedSearchProfile.savedDestinations
    }
    
    var favorites: [Place] {
        places.filter({ $0.isFavorite ?? false })
    }

    init(searchProfiles: SearchProfilesManager = SearchProfilesManager.shared, locationManager: LocationManager = LocationManager.shared) {
        self.searchProfiles = searchProfiles
        self.locationManager = locationManager
        self.lastLocation = locationManager.currentLocation ?? nil
        sortPlaces()
        setupLocationUpdates()
    }
    
    private func setupLocationUpdates() {
            cancellable = locationManager.$currentLocation // I need to understand this better! Any alternatives?
                .sink { [weak self] _ in
                    self?.resortIfNeeded()
                }
    }
    
    private func resortIfNeeded() {
        guard let currentLocation = locationManager.currentLocation else { return }
        guard let lastLocation = self.lastLocation else {
            lastLocation = currentLocation
            return
        }
        
        // Calculate distance moved since the last update
        let distanceMoved = lastLocation.distance(from: currentLocation)
        
        // Check if the distance moved exceeds the threshold (1 meter)
        if distanceMoved >= 1 {
            self.lastLocation = currentLocation
            sortPlaces()
            print(lastLocation.distance(from: currentLocation))
        }
    }
    
    private func sortPlaces() {
        let selectedSearchProfile = searchProfiles.selectedSearchProfile
        var places = selectedSearchProfile.savedDestinations
        places.sort { place1, place2 in
            let distanceToPlace1 = locationManager.distanceInMeters(to: place1.location)
            let distanceToPlace2 = locationManager.distanceInMeters(to: place2.location)
            return distanceToPlace1 ?? 0 < distanceToPlace2 ?? 0
        }
        selectedSearchProfile.savedDestinations = places
        objectWillChange.send() // to update distances in View
    }
    
    func toggleIsEdit() {
        isEdit = !isEdit
    }
    
    func distance(to location: Location) -> String? {
        return locationManager.distanceString(to: location)
    }
    
    func buttonName() -> String {
        if isEdit {
            return "Cancel"
        } else {
            return "Edit"
        }
    }
}
