//
//  Place.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-26.
//

import SwiftUI
import CoreLocation

class SearchProfile: Identifiable, Codable, Hashable, ObservableObject {
    
    var id: Int
    var title: String
    @Published var types: [LocationType]
    var locationRestriction: LocationRestriction // only save radius (as range) to Firestore
    
    @Published var savedDestinations: [Place] // don't save to Firestore - we save those separately to a sub collection
    
    //These are not used yet
    var searchString: String // don't save to Firestore
    var maxResultCount: Int  // don't save to Firestore
    var searchLocation: String // don't save to Firestore
        
    private var encodingContext: EncodingContext = .firestore //So we can encode both for the search and for the database
    
    private enum EncodingContext {
            case firestore
            case searchBody
        }
    
    init(id: Int,
         title: String,
         types: [LocationType],
         searchString: String = "",
         locationRestriction: LocationRestriction,
         maxResultCount: Int = 20,
         searchLocation: String = ""
         ) {
        self.id = id
        self.title = title
        self.types = types
        self.searchString = searchString
        self.locationRestriction = locationRestriction
        if maxResultCount < 1 { // Make sure maxResultCount is in the span 1 - 20
            self.maxResultCount = 1
        } else if maxResultCount > 20 {
            self.maxResultCount = 20
        } else {
            self.maxResultCount = maxResultCount
        }
        self.searchLocation = searchLocation
        self.savedDestinations = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FirestoreCodingKeys.self)
        
        let lat = LocationManager.shared.currentLocation?.coordinate.latitude ?? 0
        let lng = LocationManager.shared.currentLocation?.coordinate.longitude ?? 0
        let range = try container.decodeIfPresent(Double.self, forKey: .range)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        types = try container.decode([LocationType].self, forKey: .types)
        locationRestriction = LocationRestriction(circle: Circle(center: Center(latitude: lat, longitude: lng), radius: range ?? 5000))
        
        // .savedDestinations are saved as a sub collection at Firestore and fetched separately. Here, we init an array to fetch them to.
        self.savedDestinations = []
        
        // The following values are currently not saved at Firestore
        self.searchString = ""
        self.maxResultCount = 20
        self.searchLocation = ""
    }

    static func == (lhs: SearchProfile, rhs: SearchProfile) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
    
    private enum SearchBodyCodingKeys: String, CodingKey {
        case includedTypes, locationRestriction, maxResultCount
    }
    
    private enum FirestoreCodingKeys: String, CodingKey {
        case id, title, types, range
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        switch encodingContext {
        case .firestore:
            var container = encoder.container(keyedBy: FirestoreCodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(types, forKey: .types)
            try container.encode(locationRestriction.range, forKey: .range)
        case .searchBody:
            var container = encoder.container(keyedBy: SearchBodyCodingKeys.self)
            try container.encode(types.filter {$0.isChecked}.map { $0.jsonName }, forKey: .includedTypes)
            try container.encode(locationRestriction, forKey: .locationRestriction)
            try container.encode(maxResultCount, forKey: .maxResultCount)
        }
        
    }
    
    func generateFirestoreJSON() -> Data? {
        encodingContext = .firestore
        let firestoreEncoder = JSONEncoder()
        firestoreEncoder.outputFormatting = .sortedKeys // for test consistency!
                do {
                    let jsonData = try firestoreEncoder.encode(self)
                    return jsonData
                } catch {
                    print("Error encoding JSON for Firestore: \(error)")
                }
                return nil
    }
    
    func generateSearchBodyJSON() -> Data? {
        encodingContext = .searchBody
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys // for test consistency!
        
        do {
            let jsonData = try encoder.encode(self)
            return jsonData
        } catch {
            print("Error encoding JSON: \(error)")
        }

        return nil
    }
}
