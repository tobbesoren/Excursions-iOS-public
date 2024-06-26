//
//  LocationRestriction.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-28.
//

import Foundation

struct LocationRestriction: Codable, Equatable {
    static func == (lhs: LocationRestriction, rhs: LocationRestriction) -> Bool {
        return lhs.circle == rhs.circle &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.range == rhs.range
    }
    
    var circle: Circle
    var latitude: Double { circle.center.latitude }
    var longitude: Double { circle.center.longitude }
    var range: Double { circle.radius }
    
    init(circle: Circle) {
            self.circle = circle
        }
    
    // Implement custom CodingKeys to match Firestore keys
    enum CodingKeys: String, CodingKey {
        case circle
    }
    
    // Implement encode(to:) method to encode properties to Firestore-compatible structure
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(circle, forKey: .circle)
    }
    
    // Implement init(from:) initializer to reconstruct LocationRestriction from Firestore data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        circle = try container.decode(Circle.self, forKey: .circle)
    }
}

struct Circle: Codable, Equatable {
    static func == (lhs: Circle, rhs: Circle) -> Bool {
        return lhs.center == rhs.center && lhs.radius == rhs.radius
    }
    
    let center: Center
    var radius: Double
    
    init(center: Center, radius: Double) {
        self.center = center
        self.radius = radius
    }
    
    
    enum CodingKeys: String, CodingKey {
        case center
        case radius
    }
    
    
    // Implement encode(to:) method to encode properties to Firestore-compatible structure
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(center, forKey: .center)
        try container.encode(radius, forKey: .radius)
    }
    
    // Implement init(from:) initializer to reconstruct Circle from Firestore data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        center = try container.decode(Center.self, forKey: .center)
        radius = try container.decode(Double.self, forKey: .radius)
    }
}

struct Center: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        if (-90...90).contains(latitude) {
            self.latitude = latitude
        } else {
            self.latitude = 0
        }
        
        if (-180...180).contains(longitude) {
            self.longitude = longitude
        } else {
            self.longitude = 0
        }
    }
    
    // Implement custom CodingKeys to match Firestore keys
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    // Implement encode(to:) method to encode properties to Firestore-compatible structure
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    // Implement init(from:) initializer to reconstruct Center from Firestore data
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        latitude = try container.decode(Double.self, forKey: .latitude)
//        longitude = try container.decode(Double.self, forKey: .longitude)
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            let decodedLatitude = try container.decode(Double.self, forKey: .latitude)
            if (-90...90).contains(decodedLatitude) {
                latitude = decodedLatitude
            } else {
                latitude = 0.0
                print("Latitude value \(decodedLatitude) is out of range. Setting to 0.")
            }
        } catch {
            print("Error decoding latitude:", error)
            latitude = 0.0 // Set latitude to 0 if decoding fails
        }
        
        do {
            let decodedLongitude = try container.decode(Double.self, forKey: .longitude)
            if (-180...180).contains(decodedLongitude) {
                longitude = decodedLongitude
            } else {
                longitude = 0.0
                print("Longitude value \(decodedLongitude) is out of range. Setting to 0.")
            }
        } catch {
            print("Error decoding longitude:", error)
            longitude = 0.0 // Set longitude to 0 if decoding fails
        }
    }
}
