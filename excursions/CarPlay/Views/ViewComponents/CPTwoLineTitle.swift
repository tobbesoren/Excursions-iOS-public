//
//  CPTwoLineTitle.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-22.
//

import SwiftUI

struct CPTwoLineTitle: View {
    let mainTitle: String
    let subTitle: String
    
    var body: some View {
        
            VStack(alignment: .leading){
                Text(mainTitle)
                    .font(PolestarUnica77TT().size22)
                    .foregroundStyle(.black)
                Text(subTitle)
                    .font(PolestarUnica77TT().size22)
                    .foregroundStyle(.black60)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //.padding(.horizontal, 24)
    }
}


    


#Preview {
    CPTwoLineTitle(mainTitle: "Excursions", subTitle: "CarPlay")
}
