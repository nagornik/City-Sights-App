//
//  CitySightsApp.swift
//  City Sights App
//
//  Created by Anton Nagornyi on 13.05.2022.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
