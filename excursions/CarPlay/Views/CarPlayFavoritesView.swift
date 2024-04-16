//
//  CarPlayFavoritesView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-20.
//

import SwiftUI

import SwiftUI

enum CarPlayNavigationDestination: Hashable {
    case grid
    case list
    case details
}

struct CarPlayFavoritesView: View {
    
    //@ObservedObject var searchProfiles = SearchProfiles.shared
    //@Binding var loggedIn: Bool
    @State var carPlayNavigationPath: [CarPlayNavigationDestination] = []
    
    
    
    private let threeColumns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    var body: some View {
        
        NavigationStack (path: $carPlayNavigationPath){
            
                VStack {
                    CPTwoLineTitle(mainTitle: "Excursions", subTitle: "Favorites")
                        //.padding([.bottom ], 8)
                    Spacer()
                    LazyVGrid(columns: threeColumns, spacing: 4) {
                        ForEach(Array(SearchProfilesManager.shared.profiles.enumerated()), id: \.element) {index, searchProfile in
                                CarPlayGridItem(color: .parisDaisy, title: searchProfile.title)
                            .onTapGesture {
                                SearchProfilesManager.shared.updateSearchLocation(searchProfile: searchProfile)
                                SearchProfilesManager.shared.searchProfileIndex = index
                                carPlayNavigationPath.append(CarPlayNavigationDestination.list)
                                //print(searchProfile.favorites)
                            }
                        }
                    }
                    
                }
                .padding(16)
                
            
            .navigationDestination(for: CarPlayNavigationDestination.self) { destination in
                switch destination {
                case .list:
                    CarPlayListView(carPlayNavigationPath: $carPlayNavigationPath)
                case .details:
                    CarPlayDetailsView(place: SearchProfilesManager.shared.selectedPlace!)
                default: CarPlayFavoritesView()
                }
            }
            .navigationBarHidden(true)
        }.preferredColorScheme(.light)
    }
}

#Preview {
    CarPlayFavoritesView()
}
