//
//  NavigationBar.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-22.
//

import SwiftUI

struct TabBarView: View {
    @Binding var loggedIn: Bool
    @StateObject var navigationVM = NavigationVM()
    
    // Needed to change color on TabBar icons
    init(loggedIn: Binding<Bool>) {
        UITabBar.appearance().unselectedItemTintColor = .stormGray
        self._loggedIn = loggedIn
    }
    
    var body: some View {
        TabView(selection: tabSelection()) {
            SearchProfilesGridView(loggedIn: $loggedIn)
                .tabItem {
                    Image(.dashboard24)
                }
                .tag(Tab.home)
            
            FavoritesView(loggedIn: $loggedIn)
                .tabItem {
                    Image(.bookmark24)
                }
                .tag(Tab.favorites)
            
            SettingsView(loggedIn: $loggedIn)
                .tabItem {
                    Image(.avatar24)
                }
                .tag(Tab.settings)
        }
        .environmentObject(navigationVM)
        .tint(.safetyOrange)
    }
}

extension TabBarView {
    
    private func tabSelection() -> Binding<Tab> {
        Binding { //this is the get block
            self.navigationVM.selectedTab
        } set: { tappedTab in
            if tappedTab == self.navigationVM.selectedTab {
                print("Same tab tapped")
                
            } else {
                print("Other tab tapped")
            }
            // pop to root
            switch navigationVM.selectedTab {
            case .home:
                navigationVM.homeNavigationPath = []
            case .favorites:
                navigationVM.favoritesNavigationPath = []
            case .settings:
                navigationVM.settingsNavigationPath = []
            }
            //Set the tab to the tabbed tab
            self.navigationVM.selectedTab = tappedTab
                
        }
    }
}

#Preview {
    TabBarView(loggedIn: .constant(true))
}
