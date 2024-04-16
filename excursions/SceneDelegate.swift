//
//  SceneDelegate.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-20.
//

import UIKit
import SwiftUI
import CarPlay

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
    
    //var window: UIWindow?
    var externalWindow: UIWindow?
    
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("Screen connected")
        if let windowScene = scene as? UIWindowScene {
            
            if windowScene.screen.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.carPlay {
                print("CARPLAY!!!!111!!!!")
            }
            SearchProfilesManager.shared.updateProfiles()
            
            let contentView = CarPlayContentView()
            //.environmentObject(sharedCounter)
            let externalWindow = UIWindow(windowScene: windowScene)
            externalWindow.rootViewController = UIHostingController(rootView: contentView)
            self.externalWindow = externalWindow
            externalWindow.makeKeyAndVisible()
            
        }
    }

    func scene(_ scene: UIScene, didDisconnectFrom session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("CarPlay disconnected")
        if let windowScene = scene as? UIWindowScene {
            if windowScene.screen !== UIScreen.main {
                self.externalWindow = nil
            }
        }
    }
}

