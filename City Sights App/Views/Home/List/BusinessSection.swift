//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Anton Nagornyi on 14.05.2022.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        
        Section (header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                Text(business.name ?? "no data")
                Divider()
            }
        }
        
        
        
    }
}

//struct BusinessSection_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSection()
//    }
//}
