//
//  SHDetailsOverviewCollectionViewCell.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHDetailsOverviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var overviewTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setInfo(serie:SHSerie) {
        self.overviewTextView.text = serie.overview
    }
}
