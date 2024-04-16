//
//  PlaceTypeEnum.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-28.
//

import Foundation

enum PlaceTypeEnum: String, Identifiable, Codable {
    
    //Outdoor Adventure:
    case hiking_area
    case national_park
    case campground
    case ski_resort
    case marina
    case dog_park
    case farmstay
    case rv_park
    case extended_stay_hotel
    
    //Cultural Exploration:
    case art_gallery
    case museum
    case performing_arts_theater
    case cultural_center
    case historical_landmark
    case library
    case university
    
    //Landmark Discovery:
    // historical_landmark
    // museum
    case tourist_attraction
    // national_park
    case visitor_center
    case city_hall
    case embassy
    
    //Relaxation and Wellness:
    case spa
    case resort_hotel
    case bed_and_breakfast
    case private_guest_room
    //extended_stay_hotel
    
    //Entertainment:
    case amusement_park
    case casino
    case night_club
    case movie_theater
    case sports_club
    case bowling_alley
    
    //Roadtrip Essentials:
    case gas_station
    case car_dealer
    case car_rental
    case car_repair
    case car_wash
    case parking
    case rest_stop
    
    //For data base error
    case unknown
    
    var name: String {
        let formattedName = rawValue.replacingOccurrences(of: "_", with: " ")
        return formattedName.capitalized
    }
    var id: String {
        rawValue
    }
}
