//
//  FavoritesListView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-27.
//

import SwiftUI

struct FavoritesListView: View {
    @StateObject var viewModel = FavoritesListVM()
    @ObservedObject var searchProfiles = SearchProfilesManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            TwoLineTitle(mainTitle: "Favorites", subTitle: searchProfiles.selectedSearchProfile.title)
                .padding(.top, 12)
                .padding(.bottom, 28)
            ForEach(viewModel.favorites) { place in
                HStack {
                    
                    if viewModel.isEdit {
                        PlaceListItem(place: place, distance: viewModel.distance(to: place.location) )
                        Spacer()
                        Image(.crossLarge16)
                            .resizable()
                            .frame(width:24, height: 24)
                            .padding(.trailing, 24)
                            .foregroundStyle(.safetyOrange)
                            .onTapGesture {
                                withAnimation {
                                    searchProfiles.toggleFavorite(place: place)
                                }
                            }
                    } else {
                        NavigationLink(destination: DetailView(place: place)) {
                            PlaceListItem(place: place, distance: viewModel.distance(to: place.location))
                            Spacer()
                            Image(.arrowRight)
                                .resizable()
                                .frame(width:24, height: 24)
                                .padding(.trailing, 24)
                                .foregroundStyle(.safetyOrange)
                        }
                    }
                }
                Divider()
                    .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton() {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(viewModel.buttonName()) {
                    viewModel.toggleIsEdit()
                }
                .padding(.trailing, 8)
                .font(PolestarUnica77TT().size16)
                .foregroundStyle(.black)
            }
        }
    }
}

//#Preview {
//    FavoritesListView(searchProfile: SearchProfile.sampleData[0], places: Place.sampleData)
//}
