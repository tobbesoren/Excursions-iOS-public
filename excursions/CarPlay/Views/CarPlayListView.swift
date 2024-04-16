//
//  CarPlayListView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-20.
//

import SwiftUI

struct CarPlayListView: View {
    @Binding var carPlayNavigationPath: [CarPlayNavigationDestination]
    
    var body: some View {
        HStack {
            CustomBackButton() {
                carPlayNavigationPath.removeLast()
            }
            Spacer()
        }
        ScrollView {
            ForEach(SearchProfilesManager.shared.favorites) { place in
                HStack {
                        HStack {
                            Text(place.displayName.text)
                                
                            Spacer()
                            Image(.arrowRight)
                                .foregroundStyle(.safetyOrange)
                                .onTapGesture {
                                    SearchProfilesManager.shared.selectedPlace = place
                                    self.carPlayNavigationPath.append(CarPlayNavigationDestination.details)
                                }
                                //.border(.black)
                                //.padding(.trailing, 32)
                        }
                        .padding(.leading, 24)
                        .padding(.trailing, 64)
                        .onTapGesture {
                            SearchProfilesManager.shared.selectedPlace = place
                            self.carPlayNavigationPath.append(CarPlayNavigationDestination.details)
                        }
                    
                }
                
                Divider()
                    
            }.navigationBarBackButtonHidden(true)
        }
    }
}

//#Preview {
//    CarPlayListView()
//}
