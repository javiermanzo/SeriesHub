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

    @objc dynamic var id: String!
    @objc dynamic var name: String!
    @objc dynamic var overview: String!
    @objc dynamic var firstAirDate: String!
    @objc dynamic var posterImageUrl: String!
    @objc dynamic var backgroundImageUrl: String!
    @objc dynamic var deleted: Bool = false

    static func create(data: Dictionary<AnyHashable, Any>) -> SHSerie {

        let json = JSON(data)
        let serie = SHSerie()

        serie.id = json["id"].stringValue
        serie.name = json["name"].stringValue
        serie.overview = json["overview"].stringValue
        serie.firstAirDate = json["first_air_date"].stringValue
        if let imageBaseUrl = SHUserDefaults.imageBaseURL.get() {
            serie.posterImageUrl = imageBaseUrl + json["poster_path"].stringValue
            serie.backgroundImageUrl = imageBaseUrl + json["backdrop_path"].stringValue
        }
        return serie
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
