//
//  EditSearchCategory.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-27.
//

import SwiftUI
import SwiftUIFlow

struct EditSearchProfile: View {
    @ObservedObject var searchProfiles = SearchProfilesManager.shared
    @StateObject var viewModel = EditSearchProfileVM()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack {
                TwoLineTitle(mainTitle: "Edit", subTitle: searchProfiles.selectedSearchProfile.title)
                    .padding(.top, 12)
                    .padding(.bottom, 28)
                RangeSlider(range: $viewModel.radius)
                    .padding(.bottom, 28)
                Text16(text: "Types", color: .black60)
                    .padding(.bottom, 16)
                VStack {
                    VFlow(alignment: .leading, spacing: 16) {
                        ForEach(searchProfiles.selectedSearchProfile.types) { type in
                            
                            PrimaryButton(type: type) {viewModel.togglePlaceType(locationType: type)}
                                .primaryButtonStyle(isSelected: type.isChecked)
                        }
                    }
                    .padding(.horizontal, 24)
                }
                Spacer()
            }
            
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton() {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    viewModel.saveChanges()
                    dismiss()
                }
                .padding(.trailing, 8)
                .font(PolestarUnica77TT().size16)
                .foregroundStyle(.black)
            }
        }
    }
}


//#Preview {
//    let searchProfile = SearchProfile.defaultProfiles[0]
//    return EditSearchProfile(searchProfile: searchProfile)
//}
