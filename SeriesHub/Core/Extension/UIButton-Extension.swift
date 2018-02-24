//
//  UIButton-Extension.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

extension UIButton {
    
    enum SHButtonState: String {
        case subscribe = "SUBSCRIBE"
        case subscribed = "SUBSCRIBED"
    }
    
    func setUnselected(color:UIColor) {
        self.clipsToBounds = true
        self.backgroundColor = UIColor.red
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitleColor(color, for: UIControlState.normal)
        self.setTitle(SHButtonState.subscribe.rawValue, for: .normal)
    }
    
    func setSelected(color:UIColor) {
        self.clipsToBounds = true
        self.backgroundColor  = color
        self.setTitleColor(UIColor.blue, for: UIControlState.normal)
        self.setTitle(SHButtonState.subscribed.rawValue, for: .normal)
    }
    
}
