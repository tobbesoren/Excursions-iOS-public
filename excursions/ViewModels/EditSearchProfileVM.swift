//
//  EditSearchCategoryVM.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-27.
//

import SwiftUI

class EditSearchProfileVM: ObservableObject {
    var selectedSearchProfile: SearchProfile
    var searchProfiles: SearchProfilesManager
    
    @Published var title: String
    @Published var types: [LocationType]
    @Published var searchString: String
    @Published var radius: Double
    @Published var latitude: Double
    @Published var longitude: Double
    @Published var maxResultCount: Int
    @Published var searchLocation: String
    
    
    init() {
        self.searchProfiles = SearchProfilesManager.shared
        self.selectedSearchProfile = self.searchProfiles.selectedSearchProfile
        self.title = selectedSearchProfile.title
        self.types = selectedSearchProfile.types
        self.searchString = selectedSearchProfile.searchString
        self.radius = selectedSearchProfile.locationRestriction.circle.radius
        self.latitude = selectedSearchProfile.locationRestriction.circle.center.latitude
        self.longitude = selectedSearchProfile.locationRestriction.circle.center.longitude
        self.maxResultCount = selectedSearchProfile.maxResultCount
        self.searchLocation = selectedSearchProfile.searchLocation
    }
    
    func togglePlaceType(locationType: LocationType) {
        locationType.isChecked = !locationType.isChecked
        print(locationType.isChecked)
        objectWillChange.send()
    }
    
    func saveChanges() {
     
        if let index = searchProfiles.profiles.firstIndex(where: {$0.title == self.title}) {
            searchProfiles.profiles[index].types = self.types
            searchProfiles.profiles[index].locationRestriction.circle.radius = self.radius
            //self.searchProfiles.profiles[index] = profile
            DataBaseManager.shared.saveSearchProfileToFirestore(searchProfile: searchProfiles.profiles[index])
        } else {
            print("Error saving profile")
        }
    }
}
