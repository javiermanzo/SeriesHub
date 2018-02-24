//
//  SHUserDefaultsHelper.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

class SHUserDefaultsHelper {
    
    static func setImageBaseUrl(imageBaseURL:String){
        
        self.setValue(imageBaseURL, forKey: .imageBaseURL)
    }
    static func getImageBaseUrl() -> String!{
        
        if let imageBaseURL = getValue(withKey: .imageBaseURL) as? String {
            
            return imageBaseURL
        } else {
            return nil
        }
        
    }
    static func clearImageBaseUrl(){
        
        self.clearValue(forKey: .imageBaseURL)
    }
    
}

extension SHUserDefaultsHelper {
    
    fileprivate enum UserDefaultIdentifier : String {
        case imageBaseURL
        
    }
    
    fileprivate static func getBundleIndentifier() -> String{
        return Bundle.main.bundleIdentifier!
    }
    
    fileprivate static func setValue(_ value: Any, forKey key: UserDefaultIdentifier) {
        
        let key = getBundleIndentifier() + "." + key.rawValue
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    fileprivate static func getValue(withKey key: UserDefaultIdentifier) -> Any!{
        
        let key = getBundleIndentifier() + "." + key.rawValue
        
        if UserDefaults.standard.value(forKey: key) != nil {
            let value = UserDefaults.standard.value(forKey: key)
            
            return value!
        } else {
            return nil
        }
    }
    
    fileprivate static func clearValue(forKey key: UserDefaultIdentifier) {
        
        let key = getBundleIndentifier() + "." + key.rawValue
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
