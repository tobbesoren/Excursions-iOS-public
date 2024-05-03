//
//  LocationType.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-28.
//

import Foundation

class LocationType: Identifiable, Codable, ObservableObject, Equatable {
    static func == (lhs: LocationType, rhs: LocationType) -> Bool {
        return lhs.id == rhs.id && lhs.type == rhs.type
    }
    
    private let type: PlaceTypeEnum
    var jsonName: String { type.rawValue }
    @Published var isChecked = true
    var formattedName: String { type.name }
    var id: Int
    
    // Use custom CodingKeys to encode formattedName and jsonName
    enum CodingKeys: String, CodingKey {
        case isChecked
        case formattedName
        case jsonName
        case id
    }
    
    init(type: PlaceTypeEnum, id: Int) {
        self.type = type
        self.id = id
    }
    
    // Implement encode(to:) method to encode computed properties
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isChecked, forKey: .isChecked)
        try container.encode(formattedName, forKey: .formattedName)
        try container.encode(jsonName, forKey: .jsonName)
        try container.encode(id, forKey: .id)
    }
    
    // Implement init(from:) initializer to decode computed properties and restore PlaceTypeEnum
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isChecked = try container.decode(Bool.self, forKey: .isChecked)
        let jsonName = try container.decode(String.self, forKey: .jsonName)
        guard let type = PlaceTypeEnum(rawValue: jsonName) else {
            throw DecodingError.dataCorruptedError(forKey: .jsonName, in: container, debugDescription: "Invalid jsonName")
        }
        self.type = type
        id = try container.decode(Int.self, forKey: .id)
    }
    
    // Helper method to convert jsonName to PlaceTypeEnum
    func toPlaceTypeEnum() -> PlaceTypeEnum? {
        return PlaceTypeEnum(rawValue: jsonName)
    }
}
