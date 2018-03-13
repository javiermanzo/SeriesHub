//
//  SHSettings.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

enum SHSettings: String {
    case apiKey = "api_key"
    case baseUrl = "base_url"
    
    func value() -> String {
        let value = self.getValue(withKey: self)
        return value
    }
}

extension SHSettings{
    fileprivate func getValue(withKey key: SHSettings) -> String{
        let plistName = "SHSettings"
        let key = key.rawValue
        if let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let value = dict.value(forKey: key) as? String {
            return value
        } else {
            preconditionFailure("wrong color key")
        }
    }
}
