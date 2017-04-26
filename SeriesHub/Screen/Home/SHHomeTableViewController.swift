//
//  SHHomeTableViewController.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import AICustomViewControllerTransition

class SHHomeTableViewController: UITableViewController, SHHomeSubscribedSeriesProtocol {
    
    
    var customTransitioningDelegate: InteractiveTransitioningDelegate = InteractiveTransitioningDelegate()
    var lastPanRatio: CGFloat = 0.0
    let panRatioThreshold: CGFloat = 0.3
    var lastDetailViewOriginY: CGFloat = 0.0
    
    var listRecommendedSeries = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TV Show Reminder"
        
        let imageSearch = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let buttonSearch = UIBarButtonItem(image: imageSearch, style: .plain, target: self, action: #selector(showSearch))
        self.navigationItem.rightBarButtonItem = buttonSearch
        
        self.tableView.register(SHHomeTableViewCell.cellNib, forCellReuseIdentifier: SHHomeTableViewCell.id)
        self.tableView.register(SHHomeHeaderTableViewCell.cellNib, forCellReuseIdentifier: SHHomeHeaderTableViewCell.id)
        
        self.tableView.tableFooterView = UIView()
        
        self.configutreTransition()
        
        SHRequestHelper.shared.getRecomendedSeries(success: { (series) in
            self.listRecommendedSeries = series as! NSMutableArray
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listRecommendedSeries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SHHomeTableViewCell.id, for: indexPath) as! SHHomeTableViewCell
        
        let serie = self.listRecommendedSeries[indexPath.row] as! SHSerie
        
        cell.setInfo(serie: serie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SHHomeTableViewCell
        
        let serie = self.listRecommendedSeries[indexPath.row] as! SHSerie
        
        let colors = cell.serieImageView.image?.getColors()
        
        self.presentSerieDetails(serie: serie, colors: colors!)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if SHRealmHelper.shared.getSeriesList().count > 0 {
            
            return 206
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if SHRealmHelper.shared.getSeriesList().count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SHHomeHeaderTableViewCell.id) as! SHHomeHeaderTableViewCell
            
            cell.delegate = self
            cell.listSubscribedSeries = SHRealmHelper.shared.getSeriesList()
            cell.collectionView?.reloadData()
            return cell
        } else {
            return nil
        }
        
    }
    
    func showSearch(){
        let vc = SHSearchTableViewController.instanceWithDefaultNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentSerieDetails(serie:SHSerie, colors: UIImageColors){
        let vc = SHDetailsViewController.instanceWithDefaultNib()
        vc.serie = serie
        vc.colors = colors
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.customTransitioningDelegate
        
        vc.handlePan = self.getPanGestureRecognizer(originView: self.view, destinationVC: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    func configutreTransition() {
        self.customTransitioningDelegate.transitionDismiss = { (fromViewController: UIViewController, toViewController: UIViewController, containerView: UIView, transitionType: TransitionType, completion: @escaping () -> Void) in
            
            UIView.animate(withDuration: defaultTransitionAnimationDuration, animations: {
                
                fromViewController.view.alpha = 0.0
                
            }, completion: { (finished) in
                completion()
                // Reset value, since we are using a lazy var for viewController
                fromViewController.view.alpha = 1.0
            })
        }
    }
    
    func getPanGestureRecognizer(originView: UIView, destinationVC: UIViewController) -> ((_ panGestureRecognizer: UIPanGestureRecognizer) -> Void) {
        
        var handlePan: ((_ panGestureRecognizer: UIPanGestureRecognizer) -> Void)
        
        handlePan = {(panGestureRecozgnizer) in
            
            let translatedPoint = panGestureRecozgnizer.translation(in: originView)
            
            if (panGestureRecozgnizer.state == .began) {
                // Begin dismissing view controller
                self.customTransitioningDelegate.beginDismissing(viewController: destinationVC)
                self.lastDetailViewOriginY = destinationVC.view.frame.origin.y
                
            } else if (panGestureRecozgnizer.state == .changed) {
                
                let ratio: CGFloat!
                
                if (self.lastDetailViewOriginY + translatedPoint.y) > 0 {
                    ratio = (self.lastDetailViewOriginY + translatedPoint.y) / destinationVC.view.bounds.height
                } else {
                    ratio = 0
                }
                // Store lastPanRatio for next callback
                self.lastPanRatio = ratio
                
                // Update percentage of interactive transition
                self.customTransitioningDelegate.update(self.lastPanRatio)
                
                
            } else if (panGestureRecozgnizer.state == .ended) {
                // If pan ratio exceeds the threshold then transition is completed, otherwise cancel dismissal and present the view controller again
                let completed = (self.lastPanRatio > self.panRatioThreshold) || (self.lastPanRatio < -self.panRatioThreshold)
                self.customTransitioningDelegate.finalizeInteractiveTransition(isTransitionCompleted: completed)
            }
        }
        return handlePan
    }
    
    
}
