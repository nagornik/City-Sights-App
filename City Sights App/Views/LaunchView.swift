//
//  ContentView.swift
//  City Sights App
//
//  Created by Anton Nagornyi on 13.05.2022.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of geolocating the user
        if model.authorizationState == .notDetermined {
            // If undetermined, show onboarding
            
        } else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
            // If approved, show HomeView
            HomeView()
        } else {
            // If denied, show DeniedView
            
        }
       
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
