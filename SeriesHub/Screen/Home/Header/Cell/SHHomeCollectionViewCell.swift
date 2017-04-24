//
//  SHHomeCollectionViewCell.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHHomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var serieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.serieImageView.layer.cornerRadius = 4
        self.serieImageView.clipsToBounds = true
    }

}
