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
    
    var delegate:SHHomeSubscribedSeriesProtocol?
    lazy var listSubscribedSeries: Results<SHSerie> = { SHRealmHelper.shared.realm.objects(SHSerie.self) }()
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 20
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.register(SHHomeCollectionViewCell.cellNib, forCellWithReuseIdentifier: SHHomeCollectionViewCell.idCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension SHHomeHeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listSubscribedSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SHHomeCollectionViewCell.idCell, for: indexPath) as! SHHomeCollectionViewCell
        
        let serie = self.listSubscribedSeries[indexPath.row]
        cell.serieImageView.kf.setImage(with: URL(string: serie.posterImageUrl), placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil) { (image, error, cache, url) in
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let serie = self.listSubscribedSeries[indexPath.row]
        
        self.delegate?.presentSerieDetails(serie: serie)
    }
    
    
    
}
