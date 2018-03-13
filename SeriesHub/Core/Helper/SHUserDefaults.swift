//
//  SHUserDefaults.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

enum SHUserDefaults: String {
    case imageBaseURL
    
    func set(value: String) {
        self.setValue(value, forKey: self)
    }
    
    func get() -> String? {
        return self.getValue(withKey: self)
    }
    
    func clear() {
        self.clearValue(forKey: self)
    }
}

extension SHUserDefaults {
    
    fileprivate func getBundleIndentifier() -> String{
        return Bundle.main.bundleIdentifier!
    }
    
    fileprivate func setValue(_ value: String, forKey key: SHUserDefaults) {
        
        let key = self.getBundleIndentifier() + "." + key.rawValue
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    fileprivate func getValue(withKey key: SHUserDefaults) -> String?{
        let key = self.getBundleIndentifier() + "." + key.rawValue
        if let value = UserDefaults.standard.value(forKey: key) as? String {
            return value
        } else {
            return nil
        }
    }
    
    fileprivate  func clearValue(forKey key: SHUserDefaults) {
        let key = self.getBundleIndentifier() + "." + key.rawValue
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
