//
//  DetailsViewModel.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/23/22.
//

import Foundation

class DetailsViewModel {
  
    public var reloadTableView: (()->())?
    public var showError: (()->())?
    private var cellViewModels: [DetailsDaily] = [DetailsDaily]() {
        didSet {self.reloadTableView?()}
    }
    
    public var numberOfCells: Int {
        return cellViewModels.count
    }
    
    public func fetchModel(Model : [DetailsDaily]) {
            self.cellViewModels = Model
            self.reloadTableView!()
    }
    
    public func getCell (indexPaths : IndexPath) -> DetailsDaily{
        return cellViewModels[indexPaths.row]
    }
}


