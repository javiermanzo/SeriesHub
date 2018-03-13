//
//  SHGetConfigurationRequest.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHGetConfigurationRequest: SHRequestProtocol {
    
    let requestURL: String = (SHSettings.baseUrl.value() + "/3/configuration")
    
    var parameters = [String: String]()
    
    var headers: Dictionary< String, String> = [String: String]()
    
    func requestGET(success:@escaping (_ response:String) -> Void, failure:@escaping (_ error:Error) -> Void){
        
        self.requestGet(url: self.requestURL, parameters:self.parameters, headers: self.headers, success: { (data) in
            
            let baseURLImage = self.parseRequest(data: data) as! String
            success(baseURLImage)
            
        }) { (error) in
            failure(error)
            
        }
    }
    
    func parseRequest(data:Any) -> Any {
        
        let dataDictionary = data as! Dictionary<AnyHashable,Any>
        
        let images = dataDictionary["images"] as! Dictionary<AnyHashable,Any>
        
        let baseURLImage = images["base_url"] as! String
        return baseURLImage
        
    }

}
