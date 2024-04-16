//
//  DefaultSearchProfiles.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-03-28.
//

import Foundation

extension SearchProfile {
    static let defaultProfiles: [SearchProfile] = [
        SearchProfile(
            id: 1,
            title: "Outdoor Adventure",
            types: [LocationType(type: .hiking_area, id: 1),
                    LocationType(type:.national_park, id: 2),
                    LocationType(type:.campground, id: 3),
                    LocationType(type:.ski_resort, id: 4),
                    LocationType(type:.marina, id: 5),
                    LocationType(type:.dog_park, id: 6),
                    LocationType(type:.farmstay, id: 7),
                    LocationType(type:.rv_park, id: 8),
                    LocationType(type:.extended_stay_hotel, id: 9)],
            searchString: "",
            locationRestriction: LocationRestriction(
                circle: Circle(
                    center: Center(
                        latitude: 57.708870,
                        longitude: 11.974560
                    ),
                    radius: 40000
                )
            ),
            maxResultCount: 20,
            searchLocation: "Gothenburg"
        ),
        SearchProfile(
            id: 2,
            title: "Cultural Exploration",
            types: [LocationType(type:.art_gallery, id: 1),
                    LocationType(type:.museum, id: 2),
                    LocationType(type:.performing_arts_theater, id: 3),
                    LocationType(type:.cultural_center, id: 4),
                    LocationType(type:.historical_landmark, id: 5),
                    LocationType(type:.library, id: 6),
                    LocationType(type:.university, id: 7)],

            searchString: "",
            locationRestriction: LocationRestriction(
                circle: Circle(
                    center: Center(
                        latitude: 57.708870,
                        longitude: 11.974560
                    ),
                    radius: 40000
                )
            ),
            maxResultCount: 20,
            searchLocation: "Gothenburg"
        ),
        SearchProfile(
            id: 3,
            title: "Landmark Discovery",
            types: [LocationType(type: .historical_landmark, id: 1),
                    LocationType(type: .museum, id: 2),
                    LocationType(type: .tourist_attraction, id: 3),
                    LocationType(type: .national_park, id: 4),
                    LocationType(type: .visitor_center, id: 5),
                    LocationType(type: .city_hall, id: 6),
                    LocationType(type: .embassy, id: 7)],

            searchString: "",
            locationRestriction: LocationRestriction(
                circle: Circle(
                    center: Center(
                        latitude: 57.708870,
                        longitude: 11.974560
                    ),
                    radius: 40000
                )
            ),
            maxResultCount: 20,
            searchLocation: "Gothenburg"
        ),
        SearchProfile(
            id: 4,
            title: "Relaxation and\nWellness",
            types: [LocationType(type: .spa, id: 1),
                    LocationType(type: .resort_hotel, id: 2),
                    LocationType(type: .bed_and_breakfast, id: 3),
                    LocationType(type: .private_guest_room, id: 4),
                    LocationType(type: .extended_stay_hotel, id: 5)],

            searchString: "",
            locationRestriction: LocationRestriction(
                circle: Circle(
                    center: Center(
                        latitude: 57.708870,
                        longitude: 11.974560
                    ),
                    radius: 40000
                )
            ),
            maxResultCount: 20,
            searchLocation: "Gothenburg"
        ),
        SearchProfile(
            id: 5,
            title: "Entertainment",
            types: [LocationType(type: .amusement_park, id: 1),
                    LocationType(type: .casino, id: 2),
                    LocationType(type: .night_club, id: 3),
                    LocationType(type: .movie_theater, id: 4),
                    LocationType(type: .sports_club, id: 5),
                    LocationType(type: .bowling_alley, id: 6)],
            searchString: "",
            locationRestriction: LocationRestriction(
                circle: Circle(
                    center: Center(
                        latitude: 57.708870,
                        longitude: 11.974560
                    ),
                    radius: 40000
                )
            ),
            maxResultCount: 20,
            searchLocation: "Gothenburg"
        ),
        SearchProfile(
            id: 6,
            title: "Roadtrip Essentials",
            types: [LocationType(type: .gas_station, id: 1),
                    LocationType(type: .car_dealer, id: 2),
                    LocationType(type: .car_rental, id: 3),
                    LocationType(type: .car_repair, id: 4),
                    LocationType(type: .car_wash, id: 5),
                    LocationType(type: .parking, id: 6),
                    LocationType(type: .rest_stop, id: 7)],

            searchString: "",
            locationRestriction: LocationRestriction(
                circle: Circle(
                    center: Center(
                        latitude: 57.708870,
                        longitude: 11.974560
                    ),
                    radius: 40000
                )
            ),
            maxResultCount: 20,
            searchLocation: "Gothenburg"
        )
    ]
}
