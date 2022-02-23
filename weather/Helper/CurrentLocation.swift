//
//  CurrentLocation+CoreLocation.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/23/22.
//

import Foundation
import CoreLocation
import UIKit

protocol CurrentLocationDelegate : AnyObject {
    func passCurrentLocation(lat : String , lng : String)
}

typealias locationDelegate = CurrentLocationDelegate 

class CurrentLocation: NSObject , CLLocationManagerDelegate{
    
    public static let sheared = CurrentLocation()
    private weak var delegate : CurrentLocationDelegate?
    private var locationManager : CLLocationManager?
    private var currentLocation : CLLocation?
    
    public func setupLocationManager(delegate : locationDelegate ){
        locationManager = CLLocationManager()
        self.delegate = delegate
        locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation == nil {
            currentLocation = locations.last
            locationManager?.stopMonitoringSignificantLocationChanges()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
            delegate?.passCurrentLocation(lat: "\(locationValue.latitude)", lng: "\(locationValue.longitude)")
            locationManager?.stopUpdatingLocation()
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error -> \(error)")
    }
}
