//
//  SHGetAlertsRequest.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

class SHGetRecomendedSeriesRequest: SHRequestProtocol {
    
    let requestURL: String = (SHSettings.baseUrl.value() + "/3/discover/tv")
    
    var parameters: Dictionary< String, String> = [String: String]()
    
    var headers: Dictionary< String, String> = [String: String]()
    
    func request(success:@escaping (_ response:[SHSerie]) -> Void, failure:@escaping (_ error:Error) -> Void){
        
        self.requestGet(url: self.requestURL, parameters:self.parameters, headers: self.headers, success: { (data) in
            
            let resutls = data["results"] as! NSArray
            let array = self.parseRequest(data: resutls)
            
            success(array)
            
        }) { (error) in
            failure(error)
        }
    }
    
    func parseRequest(data:Any) -> [SHSerie] {
        var listSeries = [SHSerie]()
        let array = data as! NSArray
        
        for seiredData in array {
            if let dic = seiredData as? Dictionary<AnyHashable, Any>  {
                if let overview = dic["poster_path"] as? String, overview != "" {
                    let serie = SHSerie.create(data: (seiredData as? Dictionary)!)
                    listSeries.append(serie)
                }
            }
        }
        return listSeries
    }
    
}
