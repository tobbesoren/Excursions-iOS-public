//
//  ContentView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-29.
//

import SwiftUI

struct ContentView: View {
    @State var loggedIn = false
    
    var body: some View {
        if loggedIn {
            TabBarView(loggedIn: $loggedIn)
        } else {
            LoginView(loggedIn: $loggedIn)
        }
    }
}

#Preview {
    ContentView()
}
