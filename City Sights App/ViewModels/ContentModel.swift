//
//  ContentModel.swift
//  City Sights App
//
//  Created by Anton Nagornyi on 13.05.2022.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        // Init method of NSObject
        super.init()
        
        // Set ContentModel as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permition from the user
        locationManager.requestWhenInUseAuthorization()
        
        // TODO: Start geolocating the user, after we get permition
//        locationManager.startUpdatingLocation()
    }
    
    // MARK: Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            // We have permition
            // Start geolocationg the user, after we get permition
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
            // We dont' have permition

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Gives us the location of the user
        print(locations.first ?? "no data yet")
        
        // Stop requesting the location after we get it once
        locationManager.stopUpdatingLocation()
        
        // TODO: If we have the coordinates of the user, send into Yelp API
        
        
    }
    
}
