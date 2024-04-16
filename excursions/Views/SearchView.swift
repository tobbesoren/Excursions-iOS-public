//
//  SearchView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-26.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    
    @ObservedObject var searchProfiles = SearchProfilesManager.shared
    @StateObject var viewModel = SearchVM()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if viewModel.places.count > 0 {
            VStack(alignment: .leading) {
               
                Text(searchProfiles.selectedSearchProfile.title)
                    .font(PolestarUnica77TT().size30)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                
                AsyncImage(url: URL(string: "\(APIEndpoint.placePhoto.urlString)\(viewModel.places[viewModel.index].photos?[1].name ?? "")/media?maxHeightPx=400&maxWidthPx=400&key=\(ApiKeyEnvironment.apiKey)")) { image in
                    image
                        .centerCropped()
                } placeholder: {
                    Image(.placeholder)
                        .centerCropped()
                }
                .frame(height: 216, alignment: .center)
                .padding(.horizontal, 24)
                
                    
                Text("\(viewModel.distance() ?? "--") km") 
                    .padding(.leading, 24)
                    .padding(.top, 6)
                    .padding(.bottom, 2)
                    .foregroundStyle(.black60)
                
                Text(viewModel.places[viewModel.index].displayName.text)
                    .font(PolestarUnica77TT().size30)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 2)
                
                Text("Rating: \(String(format: "%.1f", viewModel.places[viewModel.index].rating)) out of 5")
                    .foregroundStyle(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                
                HStack {
                    NavigationLink(destination: DetailView(place: viewModel.places[viewModel.index])) {
                        Text("Read more")
                            .font(PolestarUnica77TT().size16)
                            .foregroundStyle(.black)
                            .padding(.leading, 24)
                        
                        Image(.arrowRight)
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.safetyOrange)
                            .padding(.leading, 1)
                    }
                }
                Spacer()
                
                HStack{
                    HStack {
                        Image(.arrowLeft)
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.safetyOrange)
                            .padding(.leading, 24)
                        Text("Discard")
                            .font(PolestarUnica77TT().size16)
                            .foregroundStyle(.black60)
                    }
                    .onTapGesture {
                        viewModel.nay()
                    }
                    Spacer()
                    HStack {
                        Text("Save")
                            .font(PolestarUnica77TT().size16)
                            .foregroundStyle(.black60)
                        Image(.arrowRight)
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.safetyOrange)
                            .padding(.trailing, 24)
                    }
                    .onTapGesture {
                        viewModel.yay()
                    }
                }
                .padding(.bottom, 24)
            }
            
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomBackButton() {
                        dismiss()
                    }
                }
            }
        } else {
            Text("Loading...")
                .onAppear {
                    PlacesApiManager.shared.nearbySearch(searchProfile: searchProfiles.selectedSearchProfile) { fetchedPlaces in
                        DispatchQueue.main.async {
                            viewModel.places = fetchedPlaces
                        }
                    }
                }
        }
    }
}



//#Preview {
//    SearchView(index: 0)
//}
