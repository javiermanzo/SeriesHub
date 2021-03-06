//
//  SHSearchTableViewCell.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import Kingfisher

class SHSearchTableViewCell: UITableViewCell {

    @IBOutlet private var serieImageView: UIImageView!
    @IBOutlet var subscribeButton: UIButton!
    @IBOutlet private var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpSubscribeButton()
    }

    func setUpSubscribeButton() {
        self.subscribeButton.roundCorners()
    }

    func setInfo(serie: SHSerie) {
        self.nameLabel.text = serie.name
        self.serieImageView.kf.setImage(with: URL(string: serie.posterImageUrl), placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: nil)
    }

    func setUnselectedButton() {
        self.subscribeButton.layer.borderWidth = 1
        self.subscribeButton.backgroundColor = UIColor.clear
        self.subscribeButton.layer.borderColor = UIColor.lightGray.cgColor
        self.subscribeButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        self.subscribeButton.setTitle("SUBSCRIBE", for: .normal)
    }

    func setSelectedButton() {
        self.subscribeButton.layer.borderWidth = 0
        self.subscribeButton.backgroundColor = UIColor.lightGray
        self.subscribeButton.setTitleColor(UIColor(hex: "#1b1b1b"), for: UIControlState.normal)
        self.subscribeButton.setTitle("SUBSCRIBED", for: .normal)
    }

}
