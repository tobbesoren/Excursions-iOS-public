//
//  SearchProfileTests.swift
//  excursionsTests
//
//  Created by Tobias Sörensson on 2024-04-26.
//

import XCTest
import FirebaseCore

final class SearchProfileTests: XCTestCase {
    
    // set this to true to generate new golden files
    static var generateGoldenFiles = false
    
    var testCasesForJsonTests: [SearchProfile] = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        // Set up test cases
        testCasesForJsonTests = [
            // Define your test cases here
            // Each test case consists of a SearchProfile
            
            // Standard
            SearchProfile(id: 1, title: "Test Profile", types: [LocationType(type: .amusement_park, id: 1)], searchString: "Test string", locationRestriction: LocationRestriction(circle: Circle(center: Center(latitude: 57.7089, longitude: 11.9746), radius: 20.0)), maxResultCount: 10, searchLocation: "Gothenburg"  ),
            
            // maxResultCount < 1
            SearchProfile(id: 1, title: "Test Profile", types: [LocationType(type: .amusement_park, id: 1)], searchString: "Test string", locationRestriction: LocationRestriction(circle: Circle(center: Center(latitude: 57.7089, longitude: 11.9746), radius: 20.0)), maxResultCount: -1, searchLocation: "Gothenburg"  ),
            
            // maxResultCount > 20
            SearchProfile(id: 1, title: "Test Profile", types: [LocationType(type: .amusement_park, id: 1)], searchString: "Test string", locationRestriction: LocationRestriction(circle: Circle(center: Center(latitude: 57.7089, longitude: 11.9746), radius: 20.0)), maxResultCount: 21, searchLocation: "Gothenburg"  ),
            // Add more test cases for different scenarios, including edge cases and failure scenarios
        ]
        
        if SearchProfileTests.generateGoldenFiles {
            generateGoldenFilesIfNeeded()
            SearchProfileTests.generateGoldenFiles = false
        }
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testInitializationWithAllProperties() {
        let testData: [(id: Int, title: String, types: [LocationType], searchString: String, maxResultCount: Int, expectedMaxResultCount: Int, searchLocation: String, latitude: Double, longitude: Double, radius: Double, expectSuccess: Bool)] = [
            (id: 1, title: "Test Profile", types: [LocationType(type: .amusement_park, id: 1)], searchString: "Test string", maxResultCount: 10, expectedMaxResultCount: 10, searchLocation: "Gothenburg", latitude: 57.7089, longitude: 11.9746, radius: 20.0, expectSuccess: true),
            // maxResultCount < 1
            (id: 1, title: "Test Profile", types: [LocationType(type: .amusement_park, id: 1)], searchString: "Test string", maxResultCount: -1, expectedMaxResultCount: 1, searchLocation: "Gothenburg", latitude: 57.7089, longitude: 11.9746, radius: 20.0, expectSuccess: true),
            // maxResultCount > 20
            (id: 1, title: "Test Profile", types: [LocationType(type: .amusement_park, id: 1)], searchString: "Test string", maxResultCount: 21, expectedMaxResultCount: 20, searchLocation: "Gothenburg", latitude: 57.7089, longitude: 11.9746, radius: 20.0, expectSuccess: true),
            // Add more test cases for different scenarios, including edge cases and failure scenarios
        ]
        
        for data in testData {
            // Arrange
            let id = data.id
            let title = data.title
            let types = data.types
            let searchString = data.searchString
            let maxResultCount = data.maxResultCount
            let searchLocation = data.searchLocation
            let latitude = data.latitude
            let longitude = data.longitude
            let radius = data.radius
            let locationRestriction = LocationRestriction(circle: Circle(center: Center(latitude: latitude, longitude: longitude), radius: radius))
            
            // Act
            let profile = SearchProfile(id: id, title: title, types: types, searchString: searchString, locationRestriction: locationRestriction, maxResultCount: maxResultCount, searchLocation: searchLocation)
            
            // Assert
            if data.expectSuccess {
                XCTAssertEqual(profile.id, id, "Initialization should set id correctly")
                XCTAssertEqual(profile.title, title, "Initialization should set title correctly")
                XCTAssertEqual(profile.types, types, "Initialization should set types correctly")
                XCTAssertEqual(profile.searchString, searchString, "Initialization should set searchString correctly")
                XCTAssertEqual(profile.locationRestriction, locationRestriction, "Initialization should set locationRestriction correctly")
                XCTAssertEqual(profile.maxResultCount, data.expectedMaxResultCount, "Initialization should set maxResultCount correctly")
                XCTAssertEqual(profile.searchLocation, searchLocation, "Initialization should set searchLocation correctly")
            } else {
                // Add assertions for failure cases if needed
            }
        }
    }
    
    func testInitializationWithOnlyMandatoryProperties() {
        let testData: [(id: Int, title: String, types: [LocationType], locationRestriction: LocationRestriction)] = [
            (id: 1, title: "Test title", types: [LocationType(type: .amusement_park, id: 1)], locationRestriction: LocationRestriction(circle: Circle(center: Center(latitude: 57.7089, longitude: 11.9746), radius: 20.0)))
            // More test cases here
        ]
        
        for data in testData {
            // Arrange
            let id = data.id
            let title = data.title
            let types = data.types
            let locationRestriction = data.locationRestriction
            
            let defaultSearchString = ""
            let defaultMaxResultCount = 20
            let defaultSearchLocation = ""
            
            // Act
            let profile = SearchProfile(id: id,
                                        title: title,
                                        types: types,
                                        locationRestriction: locationRestriction)
            
            // Assert init with all mandatory properties, i.e without searchString, maxResultCount and searchLocation
            XCTAssertEqual(profile.id, id, "Initialization should set id correctly")
            XCTAssertEqual(profile.title, title, "Initialization should set title correctly")
            XCTAssertEqual(profile.types, types, "Initialization should set types correctly")
            XCTAssertEqual(profile.searchString, defaultSearchString, "Initialization should set searchString correctly")
            XCTAssertEqual(profile.locationRestriction, locationRestriction, "Initialization should set locationRestriction correctly")
            XCTAssertEqual(profile.maxResultCount, defaultMaxResultCount, "Initialization should set maxResultCount correctly")
            XCTAssertEqual(profile.searchLocation, defaultSearchLocation, "Initialization should set searchLocation correctly")
        }
    }
    
    func testInitializationFromJSON() {
        
        struct TestData {
            let json: String
            let expectedId: Int
            let expectedTitle: String
            let expectedTypes: [LocationType]
            let expectedRange: Double
            let corruptedJson: Bool // Indicates whether the JSON data is expected to be corrupted
        }
        
        let testData: [TestData] = [
            // Proper JSON
            TestData(json: """
            {
                "id": 1,
                "title": "Test Profile",
                "types": [{"formattedName": "Hiking Area",
                            "id": 1,
                            "isChecked": true,
                            "jsonName": "hiking_area"}],
                "range": 5000
            }
        """,
                     expectedId: 1,
                     expectedTitle: "Test Profile",
                     expectedTypes: [LocationType(type: .hiking_area, id: 1)],
                     expectedRange: 5000,
                     corruptedJson: false),
            
            // Range not set in JSON, should be OK
            TestData(json: """
            {
                "id": 1,
                "title": "Test Profile",
                "types": [{"formattedName": "Hiking Area",
                            "id": 1,
                            "isChecked": true,
                            "jsonName": "hiking_area"}],
            }
        """,
                     expectedId: 1,
                     expectedTitle: "Test Profile",
                     expectedTypes: [LocationType(type: .hiking_area, id: 1)],
                     expectedRange: 5000,
                     corruptedJson: false),
            
            // Spelling error in JSON property name - 'idr'instead of 'id'
            TestData(json: """
            {
                "idr": 1,
                "title": "Test Profile",
                "types": [{"formattedName": "Hiking Area",
                            "id": 1,
                            "isChecked": true,
                            "jsonName": "hiking_area"}],
            }
        """,
                     expectedId: 1,
                     expectedTitle: "Test Profile",
                     expectedTypes: [LocationType(type: .hiking_area, id: 1)],
                     expectedRange: 5000,
                     corruptedJson: true),
            
            // Corrupted JSON
            TestData(json: """
            {
                "id": 1,
                "title": "Test Profile",
                "types": [{"formattedName": "Hiking Area",
                            "id": 1,
                            "isChecked": true,
                            "jsonName": "hiking_area"}],
            
        """,
                     expectedId: 1,
                     expectedTitle: "Test Profile",
                     expectedTypes: [LocationType(type: .hiking_area, id: 1)],
                     expectedRange: 5000,
                     corruptedJson: true)
            
            // Add more test data as needed
        ]
        
        print("\n\n")
        for data in testData {
            // Arrange
            guard let jsonData = data.json.data(using: .utf8) else {
                if data.corruptedJson {
                    print("Very Corrupted JSON???!!!")
                    XCTContext.runActivity(named: "Expected error occurred: Corrupted JSON") { _ in
                        // We shouldn't really end up here...
                    }
                } else {
                    // ...or here...
                    XCTFail("Failed to convert JSON string to data")
                }
                continue
            }
            
            // Act
            do {
                let profile = try JSONDecoder().decode(SearchProfile.self, from: jsonData)
                // Assert
                XCTAssertEqual(profile.id, data.expectedId, "Initialization should set id correctly")
                XCTAssertEqual(profile.title, data.expectedTitle, "Initialization should set title correctly")
                XCTAssertEqual(profile.types, data.expectedTypes, "Initialization should set types correctly")
                XCTAssertEqual(profile.locationRestriction.range, data.expectedRange, "Initialization should set locationRestriction range correctly")
                
            } catch {
                // Handle corrupted JSON if it's expected
                if data.corruptedJson {
                    print("JSON is in wrong format, as expected:\n\(error)\n")
                    XCTContext.runActivity(named: "Expected error occurred: JSON has wrong format") { _ in
                        // We know that the JSON is in wrong format, thus the test is successful
                    }
                } else {
                    // Probably something wrong with the test data?
                    XCTFail("Unexpectedly failed to decode JSON:\n\(error)\n")
                }
            }
        }
    }
    
    
    func testGenerateFirestoreJSON() {
        // Get the URL for the main bundle's directory
        guard let testResourcesURL = createTestDirectory() else {
            XCTFail("Test resources directory not found")
            return
        }
        
        // Iterate over the test cases
        for (index, testCase) in testCasesForJsonTests.enumerated() {
            // Arrange
            let goldenFileName = "golden_file_firestore\(index).json"
            let goldenFilePath = testResourcesURL.appendingPathComponent(goldenFileName)
            
            // Act
            guard let generatedJSON = testCase.generateFirestoreJSON() else {
                XCTFail("Error generating JSON for test case \(index)")
                continue
            }
            
            // Assert
            do {
                let expectedJSONData = try Data(contentsOf: goldenFilePath)
                
                let generatedJSONString = String(data: generatedJSON, encoding: .utf8)
                let expectedJSONString = String(data: expectedJSONData, encoding: .utf8)
                XCTAssertEqual(generatedJSONString, expectedJSONString, "Test case \(index) failed: Generated JSON does not match expected JSON")
                
            } catch {
                XCTFail("Error loading or parsing golden file \(goldenFileName): \(error)")
            }
        }
    }
    
    
    func testGenerateSearchBodyJSON() {
        // Get the URL for the main bundle's directory
        guard let testResourcesURL = createTestDirectory() else {
            XCTFail("Test resources directory not found")
            return
        }
        
        // Iterate over the test cases
        for (index, testCase) in testCasesForJsonTests.enumerated() {
            // Arrange
            let goldenFileName = "golden_file_search_body\(index).json"
            let goldenFilePath = testResourcesURL.appendingPathComponent(goldenFileName)
            
            // Act
            guard let generatedJSON = testCase.generateSearchBodyJSON() else {
                XCTFail("Error generating JSON for test case \(index)")
                continue
            }
            
            // Assert
            do {
                let expectedJSONData = try Data(contentsOf: goldenFilePath)
                
                let generatedJSONString = String(data: generatedJSON, encoding: .utf8)
                let expectedJSONString = String(data: expectedJSONData, encoding: .utf8)
                XCTAssertEqual(generatedJSONString, expectedJSONString, "Test case \(index) failed: Generated JSON does not match expected JSON")
            } catch {
                XCTFail("Error loading or parsing golden file \(goldenFileName): \(error)")
            }
        }
    }
    
    
    
    private func createTestDirectory() -> URL? {
        // Get the URL for the Documents directory
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Unable to access Documents directory")
            return nil
        }
        
        // Append a directory name for your test files
        let testDirectoryName = "TestFiles"
        let testDirectoryURL = documentsURL.appendingPathComponent(testDirectoryName)
        
        // Check if the directory already exists
        if !FileManager.default.fileExists(atPath: testDirectoryURL.path) {
            // Create the directory if it doesn't exist
            do {
                try FileManager.default.createDirectory(at: testDirectoryURL, withIntermediateDirectories: true, attributes: nil)
                print("Test directory created at: \(testDirectoryURL)")
            } catch {
                print("Error: Unable to create test directory - \(error)")
                return nil
            }
        }
        
        return testDirectoryURL
    }
    
    
    private func generateGoldenFilesIfNeeded() {
        guard !testCasesForJsonTests.isEmpty else {
            print("No test cases available to generate golden files.")
            return
        }
        
        // Get the URL for the main bundle's directory
        guard let testDirectoryPath = createTestDirectory() else {
            print("Couldn't get testDirectoryPath")
            return
        }
        
        // Iterate through test cases and generate golden files
        for (index, testCase) in testCasesForJsonTests.enumerated() {
            // Generate firestore JSON
            guard let firestoreJsonData = testCase.generateFirestoreJSON() else {
                print("Failed to generate JSON for test case at index \(index).")
                continue
            }
            
            // Write firestore JSON data to file
            let firestoreFileName = "golden_file_firestore\(index).json"
            let firestoreFilePath = testDirectoryPath.appendingPathComponent(firestoreFileName)
            do {
                try firestoreJsonData.write(to: firestoreFilePath)
                print("Golden file \(firestoreFileName) generated successfully.")
                print(firestoreFilePath)
            } catch {
                print("Failed to write JSON data to file: \(error)")
            }
            
            // Generate search body JSON
            guard let jsonData = testCase.generateSearchBodyJSON() else {
                print("Failed to generate JSON for test case at index \(index).")
                continue
            }
            
            // Write search body JSON data to file
            let searchBodyFileName = "golden_file_search_body\(index).json"
            let searchBodyFilePath = testDirectoryPath.appendingPathComponent(searchBodyFileName)
            do {
                try jsonData.write(to: searchBodyFilePath)
                print("Golden file \(searchBodyFileName) generated successfully.")
            } catch {
                print("Failed to write JSON data to file: \(error)")
            }
        }
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
