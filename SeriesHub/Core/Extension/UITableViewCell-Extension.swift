//
//  UITableViewCell-Extension.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static var idCell: String {
        return String(describing: self.self)
    }

    static var cellNib: UINib {
        return UINib(nibName: idCell, bundle: nil)
    }

}
