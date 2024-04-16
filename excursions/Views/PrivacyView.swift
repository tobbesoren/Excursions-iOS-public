//
//  PrivacyView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-27.
//

import SwiftUI


// Not used yet
struct PrivacyView: View {
    let title: String
    var body: some View {
        TwoLineTitle(mainTitle: "Excursions", subTitle: title)
    }
}

#Preview {
    PrivacyView(title: "Settings")
}
