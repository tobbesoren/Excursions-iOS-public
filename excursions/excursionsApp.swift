//
//  excursionsApp.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-19.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct excursionsApp: App {
    // AppDelegate sets up firestore.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //@StateObject var dataManager = DataManager()
    //@StateObject var placesManager = PlacesManager()
    
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                //.environmentObject(placesManager)
        }
    }
}
