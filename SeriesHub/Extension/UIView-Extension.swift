//
//  UIView-Extension.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

extension UIView {
    
    func round() {
        self.layer.cornerRadius = self.bounds.size.height/2
        self.clipsToBounds = true
    }
    
    class func instanceWithDefaultNib() -> UIView? {
        let className = NSStringFromClass(self as AnyClass).components(separatedBy:".").last
        let bundle = Bundle(for: self as AnyClass)
        
        return UINib(
            nibName: className!,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
