//
//  DetailView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-27.
//

import SwiftUI

struct DetailView: View {
    let place: Place
    @StateObject var viewModel: DetailsVM
    @Environment(\.dismiss) var dismiss
    
    init(place: Place) {
        self.place = place
        self._viewModel = StateObject(wrappedValue: DetailsVM(place: place))
    }
    
    var body: some View {
        VStack(alignment:  .leading) {
            Text(place.displayName.text)
                .font(PolestarUnica77TT().size30)
                .padding(.horizontal, 24)
                .padding(.top, 8)
            AsyncImage(url: URL(string: "\(APIEndpoint.placePhoto.urlString)\(place.photos?[1].name ?? "")/media?maxHeightPx=400&maxWidthPx=400&key=\(ApiKeyEnvironment.apiKey)")) { image in
                image
                    .centerCropped()
            } placeholder: {
                Image(.placeholder)
                    .centerCropped()
            }
            .frame(height: 216, alignment: .center)
            .padding(.horizontal, 24)
            
                Text("Top review")
                    .foregroundStyle(.black60)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 4)
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text(place.reviews?[0].text?.text ?? "No reviews")
                        .font(PolestarUnica77TT().size16)
                        .padding(.bottom, 16)
                    Text(place.typesString)
                        .font(PolestarUnica77TT().size16)
                        .foregroundStyle(.black60)
                }
                .padding(.horizontal, 24)
            }
            Spacer()
            WideButton(label: "Navigate")
                .padding(. bottom,32)
                .onTapGesture {
                    viewModel.navigateToLocation()
                }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton() {
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    DetailView(place: Place.sampleData[0])
//}
