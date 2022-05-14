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
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
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
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        authorizationState = locationManager.authorizationStatus
        
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
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
        print(locations.first ?? "no data yet")
        
    }
    
    // MARK: - Yelp API methods
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create URL
        //        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longtitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        //        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: Constants.apiUrl)
        guard urlComponents != nil else {
            return
        }
        urlComponents!.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents!.url
        
        if let url = url {
            
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            // Get URLSession
            let session = URLSession.shared
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, responce, error in
                // Check that there isn't an error
                if error == nil {
                    
                    do {
                        // Parse json
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // Sort businesses
                        var businesses = result.businesses
                        businesses.sort { (b1, b2) -> Bool  in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Call getImage function of the businesses
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            // Assign results to the appropriate property
//                            if category == Constants.sightsKey {
//                                self.sights = result.businesses
//                            } else if category == Constants.restaurantsKey {
//                                self.restaurants = result.businesses
//                            }
                            
                            // Assign results to the appropriate property
                            switch category {
                            case Constants.sightsKey:
                                self.sights = businesses
                            case Constants.restaurantsKey:
                                self.restaurants = businesses
                            default:
                                break
                            }
                            
                        }
                        
                        print(result)
                    } catch {}
                    
                    
                    
                }
            }
            // Start the Data Task
            dataTask.resume()
        }
    }
    
}
