//
//  CarPlayGridItem.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-20.
//

import SwiftUI

struct CarPlayGridItem: View {
    let color: Color
    let title: String
    let windowWidth = UIScreen.current?.bounds.width ?? 0
    let windowHeight = UIScreen.current?.bounds.height ?? 0
    
    var body: some View {

        VStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(color)
                    VStack(alignment: .leading) {
                        Text(String(title))
                            .foregroundStyle(.black60)
                            .font(PolestarUnica77TT().size12)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .horizontal], 4)
                            
                        Spacer()
                            
                        HStack {
                            Spacer()
                                
                            Image(.arrowUpRight24)
                                .foregroundStyle(.black)
                                .padding([.trailing, .bottom], 4)
                                
                        }
                    } // (2 * 16) + (2 * 4) = 40; 92 - 40 = 52;
            }
            .frame(width: (windowWidth - (2 * 32) - (2 * 8)) / 3,
                   height: (windowHeight * (0.34 / 2)) / 2)
        }
    }
}

//#Preview {
//    CategoryGridItem(color: .parisDaisy, title: "Default")
//}
