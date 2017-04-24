//
//  SHSearchTableViewController.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHSearchTableViewController: UITableViewController  {
    
    let searchController = UISearchController(searchResultsController: nil)
    var listSeries = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
                
        self.tableView.register(SHSearchTableViewCell.cellNib, forCellReuseIdentifier: SHSearchTableViewCell.id)
        
        self.configureSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         self.perform(#selector(showKeyboard), with: nil, afterDelay: 0.300)
    }
    
    func configureSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.searchBar.placeholder = "TV Show Name"
        self.searchController.searchBar.backgroundImage = UIImage()
        self.searchController.searchBar.backgroundColor = UIColor.black
        self.navigationItem.titleView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listSeries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SHSearchTableViewCell.id, for: indexPath) as! SHSearchTableViewCell

        let serie = self.listSeries[indexPath.row] as! SHSerie
        
        cell.subscribeButton.tag = indexPath.row
        
        cell.subscribeButton.addTarget(self, action: #selector(subscribeAction), for: .touchUpInside)
        
        if SHRealmHelper.shared.isSubscribed(serie: serie) {
            cell.setSelectedButton()
        } else {
            cell.setUnselectedButton()
            
        }
        
        cell.setInfo(serie: serie)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SHSearchTableViewCell
        let colors = cell.serieImageView.image?.getColors()
        
        let vc = SHDetailsViewController.instanceWithDefaultNib()
        let serie = self.listSeries[indexPath.row] as! SHSerie
        vc.serie = serie
        vc.colors = colors
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func showKeyboard() {
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchController.searchBar.resignFirstResponder()
    }
    
    func subscribeAction(sender:UIButton) {
        
        let serie = self.listSeries[sender.tag] as! SHSerie
        
        if SHRealmHelper.shared.isSubscribed(serie: serie) {
            SHRealmHelper.shared.removeSerie(serie: serie)
        } else {
            SHRealmHelper.shared.addSerie(serie: serie)
        }
        
        self.tableView.reloadData()
    }
}

extension SHSearchTableViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText =  searchController.searchBar.text, searchText.characters.count > 2 {
            filterContentForSearchText(searchController.searchBar.text!)
            
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
    }
    
    func filterContentForSearchText(_ searchText: String) {
        SHRequestHelper.shared.getSerieWithTitle(title: searchText, success: { (data) in
            self.listSeries = data as! NSMutableArray
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
}
