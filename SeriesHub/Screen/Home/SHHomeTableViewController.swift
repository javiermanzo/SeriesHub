//
//  SHHomeTableViewController.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/23/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHHomeTableViewController: UITableViewController, SHHomeSubscribedSeriesProtocol {
    
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
        
        
        self.present(vc, animated: true, completion: nil)
    }
    


    
}
