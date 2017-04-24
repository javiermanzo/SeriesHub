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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containerView.layer.cornerRadius = 4
        self.containerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfo(serie:SHSerie) {
        self.nameLabel.text = serie.name
        self.serieImageView.kf.setImage(with: URL(string: serie.backgroundImageUrl), placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: nil)
    }
    
}
