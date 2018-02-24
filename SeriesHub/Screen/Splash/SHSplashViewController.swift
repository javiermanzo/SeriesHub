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
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SHUserDefaultsHelper.getImageBaseUrl() != nil {
            self.showHomeController()
        } else {
            SHRequestHelper.shared.getConfiguration(success: { (imageBaseUrl) in
                SHUserDefaultsHelper.setImageBaseUrl(imageBaseURL: imageBaseUrl + "w500/")
                self.showHomeController()
            }) { (error) in
                print(error)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showHomeController() {
        let vc = SHHomeTableViewController.instanceWithDefaultNib()
        
        let navigationController = SHNavigationController(rootViewController: vc)
        
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            SHScreenFlowHelper.shared.changeRootViewController(viewController: navigationController)
        }
        
    }
    
}

