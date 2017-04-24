//
//  SHScreenFlowHelper.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHScreenFlowHelper {
    
    static let shared = SHScreenFlowHelper()
    
    func changeRootViewController(viewController: UIViewController!) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let snapshot:UIView = (appDelegate.window?.snapshotView(afterScreenUpdates: true))!
        viewController?.view.addSubview(snapshot);
        
        appDelegate.window?.rootViewController = viewController;
        
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview();
        });
    }
}
