//
//  UIView-Extension.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

extension UIView {
    
    static internal func instanceWithDefaultNib() -> UIView? {
        if let className = NSStringFromClass(self as AnyClass).components(separatedBy: ".").last {
            return UINib(
                nibName: className,
                bundle: nil
                ).instantiate(withOwner: nil, options: nil)[0] as? UIView
        } else {
            return nil
        }
        
    }
    
    func setUpShadow(color: CGColor = UIColor.lightGray.cgColor, opacity: Float = 0.3, offset: CGSize = CGSize.zero, radius: CGFloat = 10) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
    func roundCorners(cornerRadius: CGFloat = 4, clipsToBounds: Bool = true) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
    }
    
    func circleView() {
        //Only for perfect square views (width == height)
        let cornerRadius = self.frame.size.height / 2
        self.roundCorners(cornerRadius: cornerRadius)
    }
    
    func setUpBorder(width: CGFloat = 1, color: UIColor? = nil) {
        if let color = color {
            self.layer.borderColor = color.cgColor
        } else {
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
        self.layer.borderWidth = width
    }
    
    func removeAnimated(duration: Float = 0.3) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
