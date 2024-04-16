//
//  SearchProfiles.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-11.
//

import Foundation
import CoreLocation

class SearchProfilesManager: ObservableObject {
    static let shared = SearchProfilesManager()
    
    private var locationManager = LocationManager.shared
    
    @Published var profiles: [SearchProfile] = SearchProfile.defaultProfiles
    @Published var searchProfileIndex: Int = 0
    var selectedSearchProfile: SearchProfile { profiles[searchProfileIndex] }
    var selectedPlace: Place?
    var favorites: [Place] {
        selectedSearchProfile.savedDestinations.filter({$0.isFavorite ?? false})
    }
    
    func updateProfiles() {
        DataBaseManager.shared.fetchAllProfiles { (profiles, error) in
            if let error = error {
                // Handle any errors
                print("Error fetching profiles: \(error.localizedDescription)")
            } else if let profiles = profiles {
                // Successfully fetched profiles
                print("Fetched \(profiles.count) profiles")
                
                // Loop through fetched profiles
                for profile in profiles {
                    
//                    print("\(profile.id), \(profile.title), \(profile.allAssociatedTypes), \(profile.includedTypes), \(profile.locationRestriction), \(profile.favorites)")
                    if let index = self.profiles.firstIndex(where: {$0.title == profile.title}) {
                        print("Ohoj! \(index)")
                        self.profiles[index] = profile
                    }
                }
                for profile in SearchProfilesManager.shared.profiles {
                    DataBaseManager.shared.fetchDestinations(for: profile) { (places, error) in
                        if let error = error {
                            print("Error fetching saved destinations for \(profile.title): \(error.localizedDescription)")
                            
                        } else if let places = places {
                            profile.savedDestinations = places
                        }
                    }
                }
            }
        }
    }
    
//    func getSelectedSearchProfilePlaces() -> [Place] { // I should remove this and use the computed var selectedSearchProfile instead
//        return profiles[searchProfileIndex].savedDestinations
//    }
 

    func updateSearchLocation(searchProfile: SearchProfile) {
        guard let searchProfileIndex = profiles.firstIndex(where: {$0.title == searchProfile.title}) else { return }
        let locationRestriction = LocationRestriction(
            circle: Circle(
                center:
                    Center(latitude: locationManager.currentLocation?.coordinate.latitude ?? 0,
                           longitude: locationManager.currentLocation?.coordinate.longitude ?? 0),
                radius: profiles[searchProfileIndex].locationRestriction.circle.radius))
        searchProfile.locationRestriction = locationRestriction    }
    
    func toggleFavorite(place: Place) {
       
        if profiles[searchProfileIndex].savedDestinations.count == 0 {
            print("Error! No places found for the selected search profile.")
            return
        }
        
        guard let indexToRemove = profiles[searchProfileIndex].savedDestinations.firstIndex(where: {$0.id == place.id}) else {
            print("Error! Can't find the selected place in this search profile")
            return
        }
        profiles[searchProfileIndex]
            .savedDestinations[indexToRemove]
            .isFavorite =
        !(profiles[searchProfileIndex]
            .savedDestinations[indexToRemove]
            .isFavorite ?? false)
        DataBaseManager.shared.toggleFavorite(place: place)
        
        objectWillChange.send()
        //print(profiles[searchProfileIndex].favorites.map{ $0.displayName.text })
    }
    
    func addDestination(place: Place) {
        
        if let existingDestination = profiles[searchProfileIndex].savedDestinations.first(where: { $0.id == place.id }) {
            // Place is already saved, and we only need to update isFavorite:
            existingDestination.isFavorite = true
        } else {
            profiles[searchProfileIndex].savedDestinations.append(place)
        }
        DataBaseManager.shared.saveDestination(place: place)
    
        //print(profiles[searchProfileIndex].favorites.map{ $0.displayName.text })
    }
}

