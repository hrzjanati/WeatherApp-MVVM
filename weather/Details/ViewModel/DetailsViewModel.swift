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
    private var weekModel : [WeekDetails] = [WeekDetails]()
    private var cellViewModels: [DetailsDaily] = [DetailsDaily]() {
        didSet {self.reloadTableView?()}
    }
    
    public var numberOfCells: Int {
        return cellViewModels.count
    }
    
    public func fetchModel(Model : [WeekDetails]) {
        self.weekModel = Model
        self.cellViewModels = createDetails(Model)
        self.reloadTableView!()
    }
    
    public func getCell (indexPaths : IndexPath) -> DetailsDaily{
        return cellViewModels[indexPaths.row]
    }
    
    private func createDetails(_ model : [WeekDetails])-> [DetailsDaily]  {
        var detailsArray = [DetailsDaily]()
        for data in model {
            detailsArray.append(DetailsDaily(title: data.min, value: "MinTemp"))
            detailsArray.append(DetailsDaily(title: data.max, value: "MaxTemp"))
            detailsArray.append(DetailsDaily(title: data.sunrise.convertEpechToHour(), value: "Sunrise"))
            detailsArray.append(DetailsDaily(title: data.sunset.convertEpechToHour(), value: "Sunset"))
            detailsArray.append(DetailsDaily(title: data.moonrise.convertEpechToHour(), value: "Moonrise"))
            detailsArray.append(DetailsDaily(title: data.moonset.convertEpechToHour(), value: "Moonset"))
        }
        return detailsArray
    }
    
    
}


