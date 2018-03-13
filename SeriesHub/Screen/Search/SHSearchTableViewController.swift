//
//  SHSearchTableViewController.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class SHSearchTableViewController: UITableViewController  {
    
    lazy var viewModel = SHSearchTableViewModel(delegate: self)
    let searchController = UISearchController(searchResultsController: nil)
    var listSeries = [SHSerie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.register(SHSearchTableViewCell.cellNib, forCellReuseIdentifier: SHSearchTableViewCell.idCell)
        self.setUpSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         self.perform(#selector(showKeyboard), with: nil, afterDelay: 0.100)
    }
    
    func setUpSearchBar() {
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

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSeries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: SHSearchTableViewCell.idCell, for: indexPath) as? SHSearchTableViewCell {
            let serie = self.listSeries[indexPath.row]
            cell.subscribeButton.tag = indexPath.row
            cell.subscribeButton.addTarget(self, action: #selector(subscribeAction), for: .touchUpInside)
            
            if SHRealm.shared.isSubscribed(serie: serie) {
                cell.setSelectedButton()
            } else {
                cell.setUnselectedButton()
            }
            
            cell.setInfo(serie: serie)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let serie = self.listSeries[indexPath.row]
        let vc = SHDetailsViewController(serie: serie)
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func showKeyboard() {
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchController.searchBar.resignFirstResponder()
    }
    
    @objc func subscribeAction(sender:UIButton) {
        
        let serie = self.listSeries[sender.tag]
        
        if SHRealm.shared.isSubscribed(serie: serie) {
            SHRealm.shared.removeSerie(serie: serie)
        } else {
            SHRealm.shared.addSerie(serie: serie)
        }
        
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension SHSearchTableViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText =  searchController.searchBar.text, searchText.count > 2 {
            self.viewModel.filterContentForSearchText(searchText)
        }
    }
}

extension SHSearchTableViewController: SHSearchTableViewModelDelegate {
    func showResults(series: [SHSerie]) {
        self.listSeries = series
        self.tableView.reloadData()
    }
}
