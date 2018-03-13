//
//  SHRequestProtocol.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation
import Alamofire

protocol SHRequestProtocol {
    
    var requestURL: String { get }
    var parameters: Dictionary< String, String> { get set }
    var headers: Dictionary< String, String> { get set }
}

extension SHRequestProtocol {
    
    func requestGet(url:String, parameters:[String: String], headers:[String: String], success:@escaping (_ data:Dictionary<AnyHashable,Any>) -> Void, failure:@escaping (_ error:Error) -> Void){
        
        var param = parameters
        param["api_key"] = SHSettings.apiKey.value()
        
        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let JSON = response.result.value {
                    
                    success(JSON as! Dictionary)
                }
            case .failure(let error):
                failure(error)
            }
        }
        
        
    }

    
}
