//
//  CarPlayContentView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-20.
//

import SwiftUI

struct CarPlayContentView: View {
    @State var loggedIn = true
    var body: some View {
        CarPlayFavoritesView()
    }
}

#Preview {
    CarPlayContentView()
}

