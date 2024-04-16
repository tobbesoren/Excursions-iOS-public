//
//  SettingsView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationStack {
            TwoLineTitle(mainTitle: "Excursions", subTitle: "Settings")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            CustomBackButton() {
                                loggedIn = false
                            }
                            Text("Log out")
                                .font((PolestarUnica77TT().size16))
                                .foregroundStyle(.black)
                        }
                    }
                }
        }
    }
}

#Preview {
    SettingsView(loggedIn: .constant(true))
}
