//
//  ViewComponents.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-26.
//

import SwiftUI

struct PlaceListItem: View {
    let place: Place
    let distance: String?
    
    var body: some View {
        HStack {
            VStack {
                Text26(text: place.displayName.text, color:.ironGray)
                    .font(PolestarUnica77TT().size26)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text16(text: "\(distance ?? "--") km" , color: .stormGray)
            }
        }
    }
}

struct PrimaryButton: View {
    let type: LocationType
    let selectedImage = "cross"
    let unselectedImage = "plus"
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(type.formattedName)
                    .font(PolestarUnica77TT().size16)
                    .padding(.trailing, 4)
                Image(type.isChecked ? selectedImage : unselectedImage)
                    
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(0)
            }
        }
    }
}

struct SearchCenterView: View {
    @Binding var searchCenter: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    
    var body: some View {
        VStack {
            InputField(inputText: $searchCenter, label: "Location", guideText: "Type to search", image: Image(.search16))
//            HStack {
//                Text("Coordinates:")
//                Spacer()
//                Text("Lat: \(latitude), Lon: \(longitude)")
//            }
//            .font(PolestarUnica77TT().regular16)
//            .foregroundStyle(.subHeadingGray)
//            .padding(.horizontal, 24)
        }
    }
}

struct RangeSlider: View {
    @Binding var range: Double
    
    init(range: Binding<Double>) {
        self._range = range
        let thumbImage = UIImage(resource: .thumb10)
        let minimumTrackImage = UIImage(resource: .minTrack)
            .resizableImage(withCapInsets: .zero)
        let maximumTrackImage = UIImage(resource: .maxTrack)
            .resizableImage(withCapInsets: .zero)
        UISlider.appearance().setThumbImage(thumbImage, for: .normal)
        UISlider.appearance().setMinimumTrackImage(minimumTrackImage, for: .normal)
        UISlider.appearance().setMaximumTrackImage(maximumTrackImage, for: .normal)
        }
    
    var body: some View {
        VStack {
            HStack{
                Text("Range")
                    .font(PolestarUnica77TT().size16)
                    .foregroundStyle(.black60)
                Spacer()
                Text("km")
                    .font(PolestarUnica77TT().size16)
                    .foregroundStyle(.black)
            }
            .padding([.leading, .trailing], 24)
            Slider(value: $range, in: 0.0...50000.0, step: 100)
                .tint(.black)
                .padding([.leading, .trailing],24)
                .padding([.top, .bottom],0)
            Text16(text: "\(range/1000) km", color: .black60)
            
        }
    }
}


struct CustomBackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.arrowLeft)
                .foregroundStyle(.safetyOrange)
        }
    }
}

struct OneLineTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .font(PolestarUnica77TT().size30)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .lineSpacing(30)
    }
}

struct TwoLineTitle: View {
    let mainTitle: String
    let subTitle: String
    
    var body: some View {
        
            VStack(alignment: .leading){
                Text(mainTitle)
                    .font(PolestarUnica77TT().size30)
                Text(subTitle)
                    .font(PolestarUnica77TT().size30)
                    .foregroundStyle(.black60)
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
            .padding(.horizontal, 24)
    }
}

struct Text16: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text)
            .font(PolestarUnica77TT().size16)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
    }
}

struct Text26: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text)
            .font(PolestarUnica77TT().size26)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
    }
}

struct InputField: View {
    @Binding var inputText: String
    let label: String
    let guideText: String
    let image: Image?
    
    init(inputText: Binding<String>, label: String, guideText: String) {
        self._inputText = inputText
        self.label = label
        self.guideText = guideText
        self.image = nil
    }
    init(inputText: Binding<String>, label: String, guideText: String, image: Image) {
        self._inputText = inputText
        self.label = label
        self.guideText = guideText
        self.image = image
    }
    
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(PolestarUnica77TT().size16)
                .foregroundStyle(.black60)
                //.padding(.bottom, 8)
            ZStack {
                Rectangle()
                    .fill(.agatheGray)
                    .frame(width: UIScreen.main.bounds.width - 48, height: 48)
                    .overlay(Rectangle().frame(width: UIScreen.main.bounds.width - 48, height: 1), alignment: .bottom)
                    .foregroundStyle(.black60)
                HStack {
                    if let image {
                        image.foregroundStyle(.black60)
                    }
                        TextField(text: $inputText) {
                            Text(guideText)
                                .foregroundStyle(.textFieldGray)
                                .font(PolestarUnica77TT().size16)
                        }
                        .background(.clear)
                        .font(PolestarUnica77TT().size16)
                        Image(.crossLarge16)
                            .foregroundStyle(.black60)
                   
                }
                .frame(width: UIScreen.main.bounds.width - 80)


            }
        }
        .padding(.horizontal, 24)
    }
}

struct WideButton: View {
    let label: String
    
    var body: some View {

        ZStack {
            Rectangle()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 48)
                .foregroundStyle(.black)
                .padding([.leading, .trailing], 24)
            HStack(spacing: 0) {
                Text(label)
                    .font(PolestarUnica77TT().size16)
                    .foregroundStyle(.white)
                    //.background(.blue)
                    .frame(alignment: .leading)
                    .padding(.leading, 40)
                Image(.arrowRight)
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.safetyOrange)
                    //.background(.blue)
                    .padding(.leading, 6)
                Spacer()
            }
        }
    }
}
