//
//  CarPlayDetailsView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-20.
//

import SwiftUI

struct CarPlayDetailsView: View {
    let place: Place
    //@StateObject var viewModel: DetailsVM
    @Environment(\.dismiss) var dismiss
    
    init(place: Place) {
        self.place = place
        //self._viewModel = StateObject(wrappedValue: DetailsVM(place: place))
    }
    
    var body: some View {
        HStack {
            CustomBackButton() {
                dismiss()
            }
            Spacer()
        }
        VStack(alignment:  .leading) {
            Text(place.displayName.text)
                .font(PolestarUnica77TT().size18)
            
            Text("Top review")
                .foregroundStyle(.black60)
                .padding(.horizontal, 24)
                .padding(.bottom, 4)
            ScrollView {
                Text(place.reviews?[0].text?.text ?? "No reviews")
                    .font(PolestarUnica77TT().size16)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
            }
            Spacer()
            WideButton(label: "Navigate")
                .padding(. bottom,8)
                .onTapGesture {
                    //viewModel.navigateToLocation()
                }
        }
        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                CustomBackButton() {
//                    dismiss()
//                }
//            }
//        }
    }
}


//#Preview {
//    CarPlayDetailsView()
//}
