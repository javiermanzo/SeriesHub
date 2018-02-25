//
//  SHHomeTableViewModel.swift
//  SeriesHub
//
//  Created by javier roberto manzo on 24/2/18.
//  Copyright © 2018 Javier Manzo. All rights reserved.
//

import Foundation

protocol SHHomeTableViewModelDelegate: class {
    func showResults(series: [SHSerie])
}

class SHHomeTableViewModel {
    
    weak var delegate: SHHomeTableViewModelDelegate?
    
    init(delegate: SHHomeTableViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getRecomendedSeries() {
        SHRequestHelper.shared.getRecomendedSeries(success: { (series) in
            self.delegate?.showResults(series: series)
        }) { (error) in
            print(error)
        }
    }
}
