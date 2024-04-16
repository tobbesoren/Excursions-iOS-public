//
//  CategoriesView.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-22.
//

import SwiftUI

struct CategoryGridItem: View {
    let color: Color
    let title: String
    let windowWidth = UIScreen.current?.bounds.width
    let isEdit: Bool
    let searchImage = "arrowUpRightLarge"
    let editImage = "editLarge32"
    
    
    var body: some View {

        VStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(color)
                    VStack(alignment: .leading) {
                        Text(String(title))
                            .foregroundStyle(.black60)
                            .font(PolestarUnica77TT().size16)
                            .multilineTextAlignment(.leading)
                            .padding(12)
                        Spacer()
                        HStack {
                            Spacer()
                            Image(isEdit ? editImage : searchImage)
                                .foregroundStyle(.black)
                                .padding(12)
                        }
                    }
            }
            .frame(width: ((windowWidth ?? 0) - 2 * 16 - 4) / 2,
                   height: ((windowWidth ?? 0) - 2 * 16 - 4) / 2)
        }
    }
}

//#Preview {
//    CategoryGridItem(color: .parisDaisy, title: "Default")
//}
