//
//  SHRequestHelper.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

class SHRequestHelper: NSObject {
    
    static let shared = SHRequestHelper()
    
    private override init() {}
    
    func getRecomendedSeries(success:@escaping ( _ response:[SHSerie]) -> Void, failure:@escaping ( _ error:Error) -> Void){
        
        let getRecomendedSeriesRequest = SHGetRecomendedSeriesRequest()
        
        getRecomendedSeriesRequest.request(success: { (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
        
    }
    
    func getConfiguration(success:@escaping (_ response:String) -> Void, failure:@escaping (_ error:Error) -> Void){
        
        let configurationRequest = SHGetConfigurationRequest()
        
        configurationRequest.requestGET(success: { (data) in
            success(data)
            
        }) { (error) in
            failure(error)
            
        }
    }
    
    func getSerieWithTitle(title:String, success:@escaping (_ response:[SHSerie]) -> Void, failure:@escaping (_ error:Error) -> Void){
        
        let serieWithTitleRequest = SHGetSerieWithTitleRequest()
        
        serieWithTitleRequest.request(title: title,  success: { (data) in
            success(data)
            
        }) { (error) in
            failure(error)
            
        }
    }
}
