//
//  AppDelegate.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-19.
//


import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      print("AppDelegate")
      
      return true
  }
}
