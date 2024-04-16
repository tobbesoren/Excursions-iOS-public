//
//  SearchProfiles.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-29.
//

import SwiftUI

struct SearchProfilesGridView: View {
    @ObservedObject var searchProfiles = SearchProfilesManager.shared
    @StateObject var viewModel = SearchProfilesViewVM()
    @EnvironmentObject var navigationVM: NavigationVM
    @Binding var loggedIn: Bool
    
    private let twoColumns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    var body: some View {
        NavigationStack(path: $navigationVM.homeNavigationPath) {
            ScrollView {
                VStack {
                    TwoLineTitle(mainTitle: "Excursions", subTitle: "Explore")
                        .padding(.top, 12)
                        .padding(.bottom, 28)
                    LazyVGrid(columns: twoColumns, spacing: 4) {
                        ForEach(Array(searchProfiles.profiles.enumerated()), id: \.element) {index, searchProfile in
                            if !viewModel.isEdit {
                                CategoryGridItem(color: .parisDaisy, title: searchProfile.title, isEdit: false)
                                    
                                    .onTapGesture {
                                        searchProfiles.updateSearchLocation(searchProfile: searchProfile)
                                        searchProfiles.searchProfileIndex = index
                                        navigationVM.homeNavigationPath.append(HomeNavigationDestination.search)
                                    }
                            } else {
                                CategoryGridItem(color: .parisDaisy, title: searchProfile.title, isEdit: true)
                                    .onTapGesture {
                                        searchProfiles.updateSearchLocation(searchProfile: searchProfile)
                                        searchProfiles.searchProfileIndex = index
                                        navigationVM.homeNavigationPath.append(HomeNavigationDestination.edit)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .onAppear {
                viewModel.isEdit = false
            }
            .navigationDestination(for: HomeNavigationDestination.self) { destination in
                switch destination {
                case .search:
                    SearchView()
                case .edit:
                    EditSearchProfile()
                default: SearchProfilesGridView(loggedIn: $loggedIn)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
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
}

#Preview {
    SearchProfilesGridView(loggedIn: .constant(true))
}
