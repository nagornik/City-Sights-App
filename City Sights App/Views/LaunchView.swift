//
//  ContentView.swift
//  City Sights App
//
//  Created by Anton Nagornyi on 13.05.2022.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        
        
        Text("Hello, world!")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .background(.green)
            .cornerRadius(10)
            .shadow(color: .green, radius: 15)
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
