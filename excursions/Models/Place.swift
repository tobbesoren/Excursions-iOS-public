//
//  Place.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-26.
//

import Foundation
import SwiftUI
import CoreData

struct PlaceResponse: Decodable {
    let places: [Place]
}

class Place: Identifiable, Codable {
    let displayName: DisplayName
    let formattedAddress: String // new
    let id: String
    let location: Location
    let primaryType: PlaceTypeEnum // new
    let types: [LocationType] // new
    let reviews: [Review]?
    var isFavorite: Bool? // new
    var isDiscarded: Bool { // new, maybe just save as a bool
        !(isFavorite ?? true)
    }
    
    var typesString: String {
        var string = ""
        for type in self.types {
            if type.jsonName != "unknown" {
                string = string + "#\(type.jsonName) "
            }
        }
        print("TypeString: \(string)")
        return string
    }
    
    var rating: Double {
        guard let reviews else {return 0}
        var ratings: [Double] = []
        for review in reviews {
            if let rating = review.rating {
                ratings.append(Double(rating))
            }
        }
        return ratings.reduce(0.0, +) / Double(ratings.count)
    }
    let photos: [Photo]? // new
    
    enum CodingKeys: String, CodingKey {
            case displayName, formattedAddress, id, location, primaryType, types, reviews, isFavorite, isDiscarded, photos
        }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        displayName = try container.decode(DisplayName.self, forKey: .displayName)
        formattedAddress = try container.decode(String.self, forKey: .formattedAddress)
        id = try container.decode(String.self, forKey: .id)
        location = try container.decode(Location.self, forKey: .location)
        reviews = try container.decodeIfPresent([Review].self, forKey: .reviews)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite)
        photos = try container.decodeIfPresent([Photo].self, forKey: .photos)
        
        // Decode primaryType directly as LocationType
        let primaryTypeString = try container.decodeIfPresent(String.self, forKey: .primaryType)
        primaryType = PlaceTypeEnum(rawValue: primaryTypeString ?? "unknown") ?? .unknown
        
        // Decode types array directly as [LocationType]
        let typesStringArray = try container.decode([String].self, forKey: .types)
        types = typesStringArray.map { LocationType(type: PlaceTypeEnum(rawValue: $0) ?? .unknown, id: 1) }
    }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(displayName, forKey: .displayName)
            try container.encode(formattedAddress, forKey: .formattedAddress)
            try container.encode(id, forKey: .id)
            try container.encode(location, forKey: .location)
            try container.encode(primaryType, forKey: .primaryType)
            try container.encode(types.map({$0.jsonName }), forKey: .types)
            try container.encode(reviews, forKey: .reviews)
            try container.encode(photos, forKey: .photos)
            
            // Encode isFavorite
            try container.encode(isFavorite, forKey: .isFavorite)
            
            // Encode isDiscarded based on the value of isFavorite
            try container.encode(isDiscarded, forKey: .isDiscarded)
        }
    
    func generateFirestoreJSON() -> Data? {
        
        let firestoreEncoder = JSONEncoder()
                do {
                    let jsonData = try firestoreEncoder.encode(self)
                    return jsonData
                } catch {
                    print("Error encoding JSON for Firestore: \(error)")
                }
                return nil
    }
}

struct Photo: Codable { // new
    let authorAttributions: [AuthorAttribution]?
    let heightPx: Int? // Not sure about types here
    let widthPx: Int? // ..and here
    let name: String?
}

struct DisplayName: Codable {
    let text: String
    let languageCode: String
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

struct Review: Codable {
    let name: String?
    let relativePublishTimeDescription: String?
    let rating: Int?
    let text: TextContent?
    let originalText: TextContent?
    let authorAttribution: AuthorAttribution?
    let publishTime: String?
    
}

struct TextContent: Codable {
    let text: String
    let languageCode: String
}

struct AuthorAttribution: Codable { // for Review and Photo
    let displayName: String
    let uri: String
    let photoUri: String
    
}


