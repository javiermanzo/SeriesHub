//
//  SHSettingsHelper.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

class SHSettingsHelper {
    
    static func getApiKey() -> String!{
        if let apiKey = getValue(withKey: .apiKey) as? String {
            return apiKey
        }
        return nil
    }
    
    static func getBaseUrl() -> String!{
        if let baseUrl = getValue(withKey: .baseUrl) as? String {
            return baseUrl
        }
        return nil
    }
    
    static func getFirstColor() -> String!{
        if let firstColor = getValue(withKey: .firstColor) as? String {
            return firstColor
        }
        return nil
    }
    
    static func getSecondColor() -> String!{
        if let secondColor = getValue(withKey: .secondColor) as? String {
            return secondColor
        }
        return nil
    }
    
}

extension SHSettingsHelper{
    fileprivate static let plistName = "SHSettings"
    
    fileprivate enum SettingsIdentifier : String {
        case apiKey = "api_key"
        case baseUrl = "base_url"
        case firstColor = "first_color"
        case secondColor = "second_color"
    }
    
    fileprivate static func getValue(withKey key: SettingsIdentifier) -> Any!{
        
        let key = key.rawValue
        
        let path = Bundle.main.path(forResource: plistName, ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        if let value = dict!.value(forKey: key) {
            return value
        }
        return nil
    }
}
