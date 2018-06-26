
//
//  SHScreenFlow.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHScreenFlow {
    
    private init() {}
    
    static let shared = SHScreenFlow()
    
    let appDelegate = UIApplication.shared.delegate
    
    func changeRootViewController(viewController: UIViewController) {
        if let appDelegate = self.appDelegate as? AppDelegate,
            let snapshot = (appDelegate.window?.snapshotView(afterScreenUpdates: true)){
            viewController.view.addSubview(snapshot)
            
            appDelegate.window?.rootViewController = viewController
            
            UIView.animate(withDuration: 0.3, animations: {() in
                snapshot.layer.opacity = 0
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }, completion: {
                (value: Bool) in
                snapshot.removeFromSuperview()
            });
        }
    }
}
