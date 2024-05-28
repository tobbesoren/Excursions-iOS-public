//
//  LocationRestrictionTests.swift
//  excursionsTests
//
//  Created by Tobias Sörensson on 2024-05-03.
//

import XCTest

final class LocationRestrictionTests: XCTestCase {
    
    var centers: [Center] = []
    var circles: [Circle] = []
    var locationRestrictions: [LocationRestriction] = []

    override func setUp() {
        super.setUp()
        centers = [
            Center(latitude: 13.56, longitude: 45.67),
            Center(latitude: -45.89, longitude: -34.78)
        ]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func centerInitTest() {
        
    }
    
    func centerInitFromJsonTest() {
        
    }
    
    func circleInitTest() {
        
    }
    
    func circleInitFromJsonTest() {
        
    }
    
    func locationRestrictionInitTest() {
        
    }
    
    func locationRestrictionInitFromJsonTest() {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
