//
//  SHHomeHeaderTableViewCell.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

protocol SHHomeSubscribedSeriesProtocol {
    func presentSerieDetails(serie: SHSerie)
}

class SHHomeHeaderTableViewCell: UITableViewCell {

    var delegate: SHHomeSubscribedSeriesProtocol?
    lazy var listSubscribedSeries = SHRealm.shared.getSeriesList()
    @IBOutlet private var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }

    func setUpView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 20
        self.collectionView.collectionViewLayout = layout

        self.collectionView.register(SHHomeCollectionViewCell.cellNib, forCellWithReuseIdentifier: SHHomeCollectionViewCell.idCell)
    }

    func reload() {
        self.collectionView.reloadData()
    }
}

extension SHHomeHeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let listSubscribedSeries = self.listSubscribedSeries {
            return listSubscribedSeries.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SHHomeCollectionViewCell.idCell, for: indexPath) as? SHHomeCollectionViewCell,
            let listSubscribedSeries = self.listSubscribedSeries {
            let serie = listSubscribedSeries[indexPath.row]
            cell.setInfo(serie: serie)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listSubscribedSeries = self.listSubscribedSeries {
            let serie = listSubscribedSeries[indexPath.row]
            self.delegate?.presentSerieDetails(serie: serie)
        }
    }
}
