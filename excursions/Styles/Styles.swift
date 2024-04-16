//
//  Styles.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-11.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .padding(.bottom, 12)
            .foregroundColor(.black)
            .background(isSelected ? .safetyOrange : .white)
            .border(isSelected ? Color.clear : Color.black, width: isSelected ? 0 : 1)
            //.cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Scale effect for pressed state
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: 0.2)
             
    }
}

extension View {
    func primaryButtonStyle(isSelected: Bool) -> some View {
        self.buttonStyle(PrimaryButtonStyle(isSelected: isSelected)
        )
    }
}
