//
//  LoginView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-22.
//

import SwiftUI

struct LoginView: View {
    @Binding var loggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
     
            VStack {
                Spacer()
                Text(email)
                Spacer()
                Text(password)
                Spacer()
                TwoLineTitle(mainTitle: "Welcome to Excursions", subTitle: "Log in")
                    .padding(.bottom, 12)
                InputField(inputText: $email, label: "Email", guideText: "E-mail")
                    .padding(.top)
                InputField(inputText: $password, label: "Password", guideText: "Password")
                Spacer()
                WideButton(label: "Log in")
                        .padding(.top, 30)
                        .onTapGesture {
                            SearchProfilesManager.shared.updateProfiles()
                            //SearchProfiles.shared.getAllFavorites()
                            loggedIn = true
                        }
                Spacer()
                Spacer()
                Spacer()
            }
        }
}

#Preview {
    LoginView(loggedIn: .constant(false))
}
