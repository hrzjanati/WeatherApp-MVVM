//
//  HomeViewModel.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/13/22.
//

import Foundation
import CoreLocation
import UIKit

class HomeViewModel: CurrentLocationDelegate {
    
    public var reloadTableView: (()->())?
    public var tableViewHeader : (()->())?
    public var showError: (()->())?
    private var cellViewModels: [WeekDetails] = [WeekDetails]() {
        didSet {self.reloadTableView?()}
    }
    private var currentWeather : currentModelForView?
    public var numberOfCells: Int {
        return cellViewModels.count
    }
    public func callLocation() {
        CurrentLocation.sheared.setupLocationManager(delegate: self)
    }
    
    public func passCurrentLocation(lat: String, lng: String) {
        fetchData(lat, lng)
    }
    
    public func getcurrent() -> currentModelForView {
        return currentWeather!
    }
    
    public func getCell (indexPaths : IndexPath) -> WeekDetails{
        return cellViewModels[indexPaths.row]
    }
    
    public func createDetails(_ model : [WeekDetails])-> [DetailsDaily]  {
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
    
    private func getCurrentWeather(current : Current , timeZone : String) {
        let currModel = currentModelForView(locationName: timeZone,
                                            temp: current.temp.description.KelvinToC(),
                                            imageName: current.weather[0].main.rawValue,
                                            descrebtion: current.weather[0].weatherDescription)
        
        currentWeather = currModel
    }
    
    private func fetchData(_ lat : String , _ lng : String) {
        RequestHelper.shaered.dataRequest(with: API.latAndLong(lat: lat , long: lng).URLPathHome ,
                                          objectType: WeekWeatherModel.self) {  (result: Result) in
            switch result {
            case .success(let object):
                self.createCellModel(datas: object.daily)
                self.getCurrentWeather(current: object.current , timeZone: object.timezone)
                DispatchQueue.main.async { [self] in
                    reloadTableView?()
                    tableViewHeader?()
                }
            case .failure(let error):
                print(error)
                self.showError?()
            }
        }
    }
    
    private func createCellModel( datas : [Daily]) {
        var vms = [WeekDetails]()
        for data in datas  {
            vms.append(WeekDetails(day: "\(data.dt)".convertEpechTimeToDay(),
                                   main: data.weather[0].main.rawValue,
                                   min: "\(data.temp.min)".KelvinToC(),
                                   max: "\(data.temp.max)".KelvinToC(),
                                   sunrise: "\(data.sunrise)",
                                   sunset: "\(data.sunset)",
                                   moonrise: "\(data.moonrise)",
                                   moonset: "\(data.moonset)"))
        }
        cellViewModels = vms
    }
}

