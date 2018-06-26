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

    func persistSeriesListData(data: NSArray) -> Results<SHSerie>? {

        guard let realm = try? Realm() else {
            return nil
        }

        var seriesList: Results<SHSerie> = { realm.objects(SHSerie.self) }()

        do {
            try realm.write() {
                realm.deleteAll()

                for serieData in data {
                    let serie = SHSerie.create(data: serieData as! Dictionary<AnyHashable, Any>)
                    realm.add(serie)
                }
            }
        } catch {
            return nil
        }

        seriesList = realm.objects(SHSerie.self)

        return seriesList
    }

    func addSerie(serie: SHSerie) {
        guard let realm = try? Realm() else {
            return
        }

        do {
            try realm.write() {
                if realm.objects(SHSerie.self).filter("id == '" + serie.id + "'").first != nil {
                    serie.deleted = false
                    realm.add(serie, update: true)
                } else {
                    realm.add(serie)
                }
            }
        } catch {
            return
        }
    }

    func removeSerie(serie: SHSerie) {
        guard let realm = try? Realm() else {
            return
        }

        do {
            try realm.write() {
            serie.deleted = true
            realm.add(serie, update: true)
            }
        } catch {
                return
        }
    }

    func isSubscribed(serie: SHSerie) -> Bool {
        guard let realm = try? Realm() else {
            return false
        }
        if realm.objects(SHSerie.self).filter("id == '" + serie.id + "' AND deleted == false").first != nil {
            return true
        } else {
            return false
        }
    }

    func getSeriesList() -> Results<SHSerie>? {
        guard let realm = try? Realm() else {
            return nil
        }

        var seriesList: Results<SHSerie> = { realm.objects(SHSerie.self) }()

        seriesList = realm.objects(SHSerie.self).filter("deleted == false")

        return seriesList
    }

}
