//
//  NavigationVM.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-07.
//

import Foundation

class NavigationVM: ObservableObject {
    @Published var selectedTab: Tab = .home
    @Published var homeNavigationPath: [HomeNavigationDestination] = []
    @Published var favoritesNavigationPath: [FavoritesNavigationDestination] = []
    @Published var settingsNavigationPath: [SettingsNavigationDestination] = []
    
}

enum Tab {
  case home, favorites, settings
}

enum HomeNavigationDestination: Hashable {
    case categories
    case search
    case details
    case edit
}

enum FavoritesNavigationDestination: Hashable {
    case categories
    case listView
    case details
}

enum SettingsNavigationDestination: Hashable {
    case root
}
