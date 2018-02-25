//
//  SHSearchTableViewModel.swift
//  SeriesHub
//
//  Created by javier roberto manzo on 24/2/18.
//  Copyright © 2018 Javier Manzo. All rights reserved.
//

import Foundation

protocol SHSearchTableViewModelDelegate: class {
    func showResults(listSeries: [SHSerie])
}

class SHSearchTableViewModel {
    
    weak var delegate: SHSearchTableViewModelDelegate?
    
    init(delegate: SHSearchTableViewModelDelegate) {
        self.delegate = delegate
    }
    
    func filterContentForSearchText(_ searchText: String) {
        SHRequestHelper.shared.getSerieWithTitle(title: searchText, success: { (data) in
            self.delegate?.showResults(listSeries: data)
        }) { (error) in
            print(error)
        }
    }
}
