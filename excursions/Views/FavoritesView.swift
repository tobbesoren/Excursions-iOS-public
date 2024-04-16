//
//  FavoritesView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-29.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var navigationVM: NavigationVM
    @ObservedObject var searchProfiles = SearchProfilesManager.shared
    @Binding var loggedIn: Bool
    
    private let twoColumns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    var body: some View {
        
        NavigationStack(path: $navigationVM.favoritesNavigationPath) {
            ScrollView {
                VStack {
                    TwoLineTitle(mainTitle: "Excursions", subTitle: "Favorites")
                        .padding(.top, 56)
                        .padding(.bottom, 28)
                    LazyVGrid(columns: twoColumns, spacing: 4) {
                        ForEach(Array(searchProfiles.profiles.enumerated()), id: \.element) {index, searchProfile in
                            CategoryGridItem(color: .favoriteGray, title: searchProfile.title, isEdit: false)
                            .onTapGesture {
                                searchProfiles.updateSearchLocation(searchProfile: searchProfile)
                                searchProfiles.searchProfileIndex = index
                                navigationVM.favoritesNavigationPath.append(FavoritesNavigationDestination.listView)
                                print(searchProfile.savedDestinations)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationDestination(for: FavoritesNavigationDestination.self) { destination in
                switch destination {
                case .listView:
                    FavoritesListView()
                default: FavoritesView(loggedIn: $loggedIn)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    FavoritesView(loggedIn: .constant(true))
}
