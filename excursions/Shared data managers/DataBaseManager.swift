//
//  Networking.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-19.
//

import Foundation
import SwiftUI
import Firebase

class DataBaseManager: ObservableObject {
    let db = Firestore.firestore()
    
    let collection = "TobbesSearchProfiles"
    let subCollection = "savedDestinations"
    
    static let shared = DataBaseManager()
    
    func fetchAllProfiles(completion: @escaping ([SearchProfile]?, Error?) -> Void) {
            // Access the Firestore collection where profiles are stored
            let profilesCollection = db.collection(collection)
            
            // Construct a query to fetch all documents from the collection
            profilesCollection.getDocuments { (querySnapshot, error) in
                if let error = error {
                    // Handle any errors
                    completion(nil, error)
                    
                } else {
                    var profiles: [SearchProfile] = []
                    
                    // Iterate through the documents in the query result set
                    for document in querySnapshot!.documents {
                        do {
                            // Deserialize each document into a SearchProfile object
                            if let profileData = try document.data(as: SearchProfile?.self) {
                                profiles.append(profileData)
                            }
                        } catch {
                            // Handle any errors while deserializing data
                            completion(nil, error)
                            return
                        }
                    }
                    
                    // Call the completion handler with the fetched profiles
                    completion(profiles, nil)
                }
            }
        }
    
    func saveSearchProfileToFirestore(searchProfile: SearchProfile) {
        do {
            // Convert SearchProfile to JSON data
            guard let jsonData = searchProfile.generateFirestoreJSON() else {
                print("Error: Failed to generate JSON data")
                return }

            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("Error converting JSON data to dictionary")
                return
            }

            let docRef = db.collection(collection).document(String(searchProfile.id))
            docRef.setData(json, merge: true) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added/updated with ID: \(docRef.documentID)")
                }
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
    
    func saveDestination(place: Place) {
        do {
            guard let jsonData = place.generateFirestoreJSON() else {
                print("Error: Failed to generate JSON data")
                return }

            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                print("Error converting JSON data to dictionary")
                return
            }
            
            let docRef = db.collection(collection).document(String(SearchProfilesManager.shared.selectedSearchProfile.id)).collection(subCollection)
            
            // Add the document to the sub-collection
            docRef.document(place.id).setData(json) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    print("Document successfully updated.")
                }
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
    
    func toggleFavorite(place: Place) {
        let placeRef = db.collection(collection)
            .document(String(SearchProfilesManager.shared.selectedSearchProfile.id))
                          .collection(subCollection)
                          .document(place.id)

        // Update the isFavorite field of the document
        placeRef.updateData(["isFavorite": (place.isFavorite ?? false), "isDiscarded": (place.isDiscarded)]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated!")
            }
        }
    }
    
    func fetchDestinations(for searchProfile: SearchProfile, completion: @escaping ([Place]?, Error?) -> Void) {
        let savedDestinationsCollection = db.collection(collection).document(String(searchProfile.id)).collection(subCollection)
        // Construct a query to fetch all documents from the collection
        savedDestinationsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                // Handle any errors
                print(error)
                completion(nil, error)
                
            } else {
                var locations: [Place] = []
                
                // Iterate through the documents in the query result set
                for document in querySnapshot!.documents {
                    print(document)
                    do {
                        // Deserialize each document into a SearchProfile object
                        if let placeData = try document.data(as: Place?.self) {
                            locations.append(placeData)
                        }
                    } catch {
                        if let decodingError = error as? DecodingError {
                            print(decodingError)
                        }
                        // Handle any errors while deserializing data
                        print("Ohoj")
                        completion(nil, error)
                        return
                    }
                }
                
                // Call the completion handler with the fetched profiles
                completion(locations, nil)
            }
        }
    }
}
