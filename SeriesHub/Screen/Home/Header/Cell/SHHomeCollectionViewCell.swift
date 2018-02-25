//
//  SHHomeCollectionViewCell.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHHomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var serieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.serieImageView.roundCorners()
    }

    func setInfo(serie:SHSerie) {
        self.serieImageView.kf.setImage(with: URL(string: serie.posterImageUrl), placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: nil)
    }
}
