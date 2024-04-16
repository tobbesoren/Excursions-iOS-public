//
//  DetailsVM.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-18.
//

import SwiftUI

class DetailsVM: ObservableObject {
    @Published var place: Place
    
    init(place: Place) {
        self.place = place
    }
    
    func navigateToLocation() { // I think I should let the user select which map service to use in Settings.
        let latitude = place.location.latitude
        let longitude = place.location.longitude
        
        // As default, open Google Maps to make the experience as close to the android version's as possible.
        if let url = URL(string: "comgooglemaps://?daddr=\(latitude),\(longitude)&directionsmode=driving") {
            // Try to open Google Maps
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                return
            } else {
                print("Google Maps not available. Let's try Apple maps instead.")
            }
        }
        
        // If Google Maps is not available, open Apple Maps
        let coordinates = "\(latitude),\(longitude)"
        if let url = URL(string: "http://maps.apple.com/?daddr=\(coordinates)&dirflg=d") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
