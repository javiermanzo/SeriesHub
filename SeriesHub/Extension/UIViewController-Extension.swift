//
//  UIViewController-Extension.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit


extension UIViewController {
    static func instanceWithDefaultNib() -> Self {
        
        let className = NSStringFromClass(self as! AnyClass).components(separatedBy:".").last
        let bundle = Bundle(for: self as! AnyClass)
        return self.init(nibName: className, bundle: bundle)
    }
}


extension UIViewController : StoryboardIdentifiable { }

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
