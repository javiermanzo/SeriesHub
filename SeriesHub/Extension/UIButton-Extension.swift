//
//  UIButton-Extension.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import DynamicColor

extension UIButton {
    
    func setUnselected(color:UIColor) {
        
        self.clipsToBounds = true
        self.backgroundColor = color.inverted()
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        self.setTitleColor(color, for: UIControlState.normal)
        self.setTitle("SUBSCRIBE", for: .normal)
    }
    
    func setSelected(color:UIColor) {
        
        self.clipsToBounds = true
        self.backgroundColor  = color
        self.setTitleColor(color.inverted(), for: UIControlState.normal)
        self.setTitle("SUBSCRIBED", for: .normal)
    }
    
}
