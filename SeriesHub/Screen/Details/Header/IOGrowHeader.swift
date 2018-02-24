//
//  IOParallaxHeader.swift
//  IOStickyHeader
//
//  Created by ben on 29/06/2015.
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//

import UIKit
import IOStickyHeader
import Kingfisher


class IOGrowHeader: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var constraintImgSize: NSLayoutConstraint!
    
    let imageHeaderWidth:CGFloat = 140
    
    override func awakeFromNib() {
        self.imgPhoto.layer.cornerRadius = 4
        self.subscribeButton.circleView()
        self.setUpView()
    }
    
    func setUpView() {
        self.containerView.backgroundColor = UIColor.red
        self.nameLabel.textColor = UIColor.green
        self.yearLabel.textColor = UIColor.blue
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let layoutAttributes:IOStickyHeaderFlowLayoutAttributes = layoutAttributes as? IOStickyHeaderFlowLayoutAttributes else { return }
        
        if layoutAttributes.progressiveness < 1 {
            self.constraintImgSize.constant = max(self.imageHeaderWidth * layoutAttributes.progressiveness, 60)
            self.imgPhoto.updateConstraintsIfNeeded()
        } else {
            self.constraintImgSize.constant = self.imageHeaderWidth * layoutAttributes.progressiveness
            self.imgPhoto.updateConstraintsIfNeeded()
        }
    }
    
    func setInfo(serie:SHSerie) {
        self.nameLabel.text = serie.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        if let date = dateFormatter.date(from: serie.firstAirDate) {
            self.yearLabel.text = String(Calendar.current.component(.year, from: date))
        } else {
            self.yearLabel.text = ""
        }
        
    }
    
}
