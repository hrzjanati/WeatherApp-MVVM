//
//  HomeViewModel.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/13/22.
//

import Foundation
import CoreLocation
import UIKit

class HomeViewModel {
    public var reloadTableView: (()->())?
    public var tableViewHeader = UIView()
    public var showError: (()->())?
    private var cellViewModels: [dailyDetails] = [dailyDetails]() {
        didSet {self.reloadTableView?()}
    }
    private var currentWeather : currentModelForView?
    public var numberOfCells: Int {
        return cellViewModels.count
    }
    
    public func fetchData( complition : @escaping () -> (Void)) {
        CurrentLocation.sheared.getGPSLocation { lat, lng in
            RequestHelper.shaered.dataRequest(with:"https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lng)&exclude=24,7&appid=628409d2c72ec95050248eb8dd5a6f22" ,
                                              objectType: WeekWeatherModel.self) {  (result: Result) in
                switch result {
                case .success(let object):
                    print(object)
                    self.createCellModel(datas: object.daily)
                    self.getCurrentWeather(current: object.current , timeZone: object.timezone)
                    DispatchQueue.main.async { [self] in
                        self.reloadTableView?()
                        complition()
                    }
                case .failure(let error):
                    print(error)
                    self.showError?()
                }
            }
            
        }
    }
    
    private func getCurrentWeather(current : Current , timeZone : String) {
       let currModel = currentModelForView(locationName: timeZone,
                                           temp: current.temp.description.KelvinToC(),
                                           imageName: current.weather[0].main.rawValue,
                                           descrebtion: current.weather[0].weatherDescription)
        
        currentWeather = currModel
    }
    public func getcurrent() -> currentModelForView {
        return currentWeather!
    }
    
    public func getCell (indexPaths : IndexPath) -> dailyDetails{
        return cellViewModels[indexPaths.row]
    }
    
    
    private func createCellModel( datas : [Daily]) {
        var vms = [dailyDetails]()
        for data in datas  {
            vms.append(dailyDetails(day: "\(data.dt)".convertEpechTimeToDate(),
                                    main: data.weather[0].main.rawValue,
                                    min: "\(data.temp.min)".KelvinToC(),
                                    max: "\(data.temp.max)".KelvinToC()))
        }
        cellViewModels = vms
    }

}

