//
//  SHSplashViewController.swift
//  SeriesHub
//
//  Created by javier roberto manzo on 24/2/18.
//  Copyright © 2018 Javier Manzo. All rights reserved.
//

import UIKit

class SHSplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SHUserDefaults.imageBaseURL.get() != nil {
            self.showHomeController()
        } else {
            SHRequestHelper.shared.getConfiguration(success: { (imageBaseUrl) in
                SHUserDefaults.imageBaseURL.set(value: imageBaseUrl + "w500/")
                self.showHomeController()
            }) { (error) in
                print(error)
            }
        }
    }
    
    func showHomeController() {
        let vc = SHHomeTableViewController.instanceWithDefaultNib()
        let navigationController = SHNavigationController(rootViewController: vc)
        
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when) {
            SHScreenFlow.shared.changeRootViewController(viewController: navigationController)
        }
    }
    
}

