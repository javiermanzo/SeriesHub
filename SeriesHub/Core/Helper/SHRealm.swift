//
//  SHRealm.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation
import RealmSwift

class SHRealm {

    private init() {}

    static let shared = SHRealm()

    let realm = try! Realm()

    func persistSeriesListData(data: NSArray) -> Results<SHSerie> {

        var seriesList: Results<SHSerie> = { self.realm.objects(SHSerie.self) }()

        try! realm.write() {

            realm.deleteAll()

            for serieData in data {
                let serie = SHSerie.create(data: serieData as! Dictionary<AnyHashable, Any>)
                self.realm.add(serie)
            }
        }

        seriesList = realm.objects(SHSerie.self)

        return seriesList
    }

    func addSerie(serie: SHSerie) {
        try! realm.write {
            if realm.objects(SHSerie.self).filter("id == '" + serie.id + "'").first != nil {
                serie.deleted = false
                realm.add(serie, update: true)
            } else {
                realm.add(serie)
            }
        }
    }

    func removeSerie(serie: SHSerie) {
        try! realm.write {
            serie.deleted = true
            realm.add(serie, update: true)
        }
    }

    func isSubscribed(serie: SHSerie) -> Bool {
        if realm.objects(SHSerie.self).filter("id == '" + serie.id + "' AND deleted == false").first != nil {
            return true
        } else {
            return false
        }
    }

    func getSeriesList() -> Results<SHSerie> {
        var seriesList: Results<SHSerie> = { self.realm.objects(SHSerie.self) }()

        seriesList = realm.objects(SHSerie.self).filter("deleted == false")

        return seriesList
    }

}
