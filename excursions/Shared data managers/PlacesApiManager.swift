//
//  PlacesManager.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-20.
//

import Foundation
//import GooglePlaces
import SwiftUI

class PlacesApiManager: ObservableObject {
    static let shared = PlacesApiManager()
    
    func fetchPlace(id: String, completion: @escaping (Place?) -> Void) -> Void {
        guard let url = URL(string: "\(APIEndpoint.placeDetails.urlString)\(id)") else {
            print("Error getting API endpoint")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ApiKeyEnvironment.apiKey, forHTTPHeaderField: "X-Goog-Api-Key")
        request.setValue("displayName,id,location,reviews", forHTTPHeaderField: "X-Goog-FieldMask")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                if String(data: data, encoding: .utf8) == nil {
                    print("Error converting place data to string.")
                }
                //print(String(data: data, encoding: .utf8) ?? "What?")
                do {
                    let decoder = JSONDecoder.shared // Shared instance for better performance
                    let place = try decoder.decode(Place.self, from: data)
                    
                    //print(place)
                    completion(place)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown Error")")
                completion(nil)
            }
        }
        .resume()
    }
    
    func nearbySearch(searchProfile: SearchProfile, completion: @escaping ([Place]) -> Void) {
        guard let url = URL(string: APIEndpoint.nearbySearch.urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ApiKeyEnvironment.apiKey, forHTTPHeaderField: "X-Goog-Api-Key")
        print("API-key: \(ApiKeyEnvironment.apiKey)")
        request.setValue("places.displayName,places.formattedAddress,places.id,places.location,places.photos,places.primaryType,places.types,places.reviews", forHTTPHeaderField: "X-Goog-FieldMask") // updated
        
        if let jsonPayload = searchProfile.generateSearchBodyJSON() {
            
            request.httpBody = jsonPayload
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if String(data: data, encoding: .utf8) == nil {
                        print("Error converting data to string.")
                    } else {
                        print(String(data: data, encoding: .utf8) ?? "Hmm")
                    }
                    //print(String(data: data, encoding: .utf8) ?? "OOps")

                    do {
                        let decoder = JSONDecoder.shared // Shared instance for better performance
                        let apiResponse = try decoder.decode(PlaceResponse.self, from: data)
                        
                        let places = apiResponse.places
                        print(places)
                        completion(places)
                        
                    } catch {
                        print("Error decoding data: \(error)")
                        
                        completion([])
                    }
                } else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    completion([])
                }
            }.resume()
        }
    }
}

// Shared JSONDecoder instance
extension JSONDecoder {
    static let shared: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
