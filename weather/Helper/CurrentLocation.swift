//
//  CurrentLocation.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/13/22.
//

import Foundation
import MapKit
import CoreLocation

class CurrentLocation : NSObject , CLLocationManagerDelegate{
    
    public static let sheared = CurrentLocation()
    private let locationManager = CLLocationManager()
    
    public func getGPSLocation(completion: (_ lat: String, _ lng: String) -> Void) {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                print("No access")
                locationManager.requestWhenInUseAuthorization()
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                let locManager = CLLocationManager()
                var currentLocation: CLLocation!
                locManager.desiredAccuracy = kCLLocationAccuracyBest
                currentLocation = locManager.location
                let latitude = String(format: "%.7f", currentLocation.coordinate.latitude)
                let longitude = String(format: "%.7f", currentLocation.coordinate.longitude)
                completion(latitude, longitude)
                @unknown default:
                    break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    
}
