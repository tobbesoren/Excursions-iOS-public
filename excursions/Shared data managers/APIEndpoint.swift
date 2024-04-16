//
//  APIEndpoint.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-01.
//

import Foundation

enum APIEndpoint {
    case nearbySearch
    case textSearch
    case placeDetails
    case placePhoto
    case autoComplete
    
    var urlString: String {
        switch self {
        case .nearbySearch: return "https://places.googleapis.com/v1/places:searchNearby"
        case .textSearch: return "https://places.googleapis.com/v1/places:searchText"
        
        case .placeDetails: return "https://places.googleapis.com/v1/places/" // https://places.googleapis.com/v1/places/PLACE_ID
        case .placePhoto: return "https://places.googleapis.com/v1/" //https://places.googleapis.com/v1/NAME/media?key=API_KEY&PARAMETERS
        case .autoComplete: return "https://places.googleapis.com/v1/places:autocomplete"
        }
    }
}
