//
//  SHMovie.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class SHSerie: Object {
    
    dynamic var id: String!
    dynamic var name: String!
    dynamic var overview: String!
    dynamic var firstAirDate: String!
    dynamic var posterImageUrl: String!
    dynamic var backgroundImageUrl: String!
    dynamic var deleted: Bool = false
    
    static func create(data: Dictionary<AnyHashable,Any>) -> SHSerie {
        
        let json = JSON(data)
        let serie = SHSerie()
        
        serie.id = json["id"].stringValue
        serie.name = json["name"].stringValue
        serie.overview = json["overview"].stringValue
        serie.firstAirDate = json["first_air_date"].stringValue
        serie.posterImageUrl =  SHUserDefaultsHelper.getImageBaseUrl() + json["poster_path"].stringValue
        serie.backgroundImageUrl = SHUserDefaultsHelper.getImageBaseUrl() + json["backdrop_path"].stringValue
        
        return serie
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
