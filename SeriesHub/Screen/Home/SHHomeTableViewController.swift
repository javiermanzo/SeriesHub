//
//  SHHomeTableViewController.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import AICustomViewControllerTransition

class SHHomeTableViewController: UITableViewController {
    
    lazy var viewModel = SHHomeTableViewModel(delegate: self)
    var customTransitioningDelegate: InteractiveTransitioningDelegate = InteractiveTransitioningDelegate()
    var lastPanRatio: CGFloat = 0.0
    let panRatioThreshold: CGFloat = 0.3
    var lastDetailViewOriginY: CGFloat = 0.0
    
    var listRecommendedSeries = [SHSerie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        self.configutreTransition()
        
        self.viewModel.getRecomendedSeries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.setUpHeader()
    }
    
    func setUpView() {
        self.title = "TV Show Reminder"
        
        let imageSearch = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let buttonSearch = UIBarButtonItem(image: imageSearch, style: .plain, target: self, action: #selector(showSearch))
        self.navigationItem.rightBarButtonItem = buttonSearch
        
        self.tableView.register(SHHomeTableViewCell.cellNib, forCellReuseIdentifier: SHHomeTableViewCell.idCell)
        
        self.tableView.tableFooterView = UIView()
    }
    
    func setUpHeader() {
        if let header = SHHomeHeaderTableViewCell.instanceWithDefaultNib() as? SHHomeHeaderTableViewCell, SHRealm.shared.getSeriesList().count > 0 {
            self.tableView.tableHeaderView = header
            header.delegate = self
            header.reload()
        } else {
            self.tableView.tableHeaderView = nil
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listRecommendedSeries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SHHomeTableViewCell.idCell, for: indexPath) as? SHHomeTableViewCell {
            let serie = self.listRecommendedSeries[indexPath.row]
            cell.setInfo(serie: serie)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let serie = self.listRecommendedSeries[indexPath.row]
        self.presentSerieDetails(serie: serie)
    }
    
    @objc func showSearch(){
        let vc = SHSearchTableViewController.instanceWithDefaultNib()
        self.navigationController?.pushViewController(vc, animated: true)
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

extension SHHomeTableViewController: SHHomeTableViewModelDelegate {
    func showResults(series: [SHSerie]) {
        self.listRecommendedSeries = series
        self.tableView.reloadData()
    }
}

extension SHHomeTableViewController: SHHomeSubscribedSeriesProtocol {
    func presentSerieDetails(serie:SHSerie){
        let vc = SHDetailsViewController(serie: serie)
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.customTransitioningDelegate
        
        vc.handlePan = self.getPanGestureRecognizer(originView: self.view, destinationVC: vc)
        self.present(vc, animated: true, completion: nil)
    }
}

