//
//  Environment.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-19.
//

import Foundation

public enum ApiKeyEnvironment {
    enum Keys {
        static let apiKey = "API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let apiKey: String = {
        guard let apiKeyString = ApiKeyEnvironment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API key not set in plist")
        }
       
        return apiKeyString
    }()
}
