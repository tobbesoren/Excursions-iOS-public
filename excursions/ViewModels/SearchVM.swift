//
//  SearchVM.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-14.
//

import SwiftUI
import CoreLocation

class SearchVM: ObservableObject {
    @Published var places: [Place] = []
    @Published var index = 0
    var currentPlace: Place { places[index] }
    var searchProfiles = SearchProfilesManager.shared
    var locationManager = LocationManager.shared
    
    func yay() {
        currentPlace.isFavorite = true
        searchProfiles.addDestination(place: currentPlace)
        nextPlace()
    }
    
    func nay() {
        nextPlace()
    }
    
    func nextPlace() {
        if index < places.count - 1 {
            index += 1
        } else {
            return
        }
    }
    
    func distance() -> String? {
        return locationManager.distanceString(to: places[index].location)
    }
    
}
