//
//  SHHomeTableViewCell.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import Kingfisher

class SHHomeTableViewCell: UITableViewCell {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var serieImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }

    func setUpView() {
        self.containerView.roundCorners()
    }

    func setInfo(serie:SHSerie) {
        self.nameLabel.text = serie.name
        self.serieImageView.kf.setImage(with: URL(string: serie.backgroundImageUrl), placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: nil)
    }
}
