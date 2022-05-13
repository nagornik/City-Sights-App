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
        let userLocation = locations.first
        if userLocation != nil {
            // We have a location
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            // If we have the coordinates of the user, send into Yelp API
            //            getBusinesses(category: "arts", location: userLocation!)
            getBusinesses(category: "restaurants", location: userLocation!)
        }
        print(locations.first ?? "no data yet")
        
    }
    
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create URL
        //        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longtitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        //        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        guard urlComponents != nil else {
            return
        }
        urlComponents!.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longtitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents!.url
        
        if let url = url {
            
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer 7-f6l6flPnJhxHNDLECBbwyuGTDrkB7PwDGuvB0I_tx1CM533XfW7uT9NklqU_Qy6yK0bi58QkmHqJQgTYTNTxEXRckOyOFC99-DAh12oZRqz8DhRb5ksYJmc71-YnYx", forHTTPHeaderField: "Authorization")
            // Get URLSession
            let session = URLSession.shared
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, responce, error in
                // Check that there isn't an error
                if error == nil {
                    print(responce)
                }
            }
            // Start the Data Task
            dataTask.resume()
        }
    }
    
}
