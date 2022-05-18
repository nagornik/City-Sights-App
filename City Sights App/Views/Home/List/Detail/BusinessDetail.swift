//
//  BusinessDetail.swift
//  City Sights App
//
//  Created by Anton Nagornyi on 16.05.2022.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading, spacing: 0) {
                GeometryReader { geo in
                    
                    
                    // Image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .padding(0)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                    
                }
                .edgesIgnoringSafeArea(.top)
                
                // Open / closed indicator
                ZStack (alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
                .padding(0)
                
                
//                Spacer()
            }
            
            
            
            Group {
                
                // Business name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                // Loop through displayAddress
                if business.location?.displayAddress != nil {
                    ForEach(business.location!.displayAddress!, id:\.self) { displayLine in
                        Text(displayLine)
                            .padding(.leading)
                    }
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                
                Divider()
                
                Group {
                    // Phone
                    HStack {
                        Text("Phone: ")
                            .bold()
                        Text(business.displayPhone ?? "")
                        Spacer()
                        Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                    }
                    .padding()
                    Divider()
                    
                    // Reviews
                    HStack {
                        Text("Reviews: ")
                            .bold()
                        Text(String(business.reviewCount ?? 0))
                        Spacer()
                        Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                    }
                    .padding()
                    Divider()
                    
                    // Website
                    HStack {
                        Text("Website: ")
                            .bold()
                        Text(business.url ?? "")
                            .lineLimit(1)
                        Spacer()
                        Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                    }
                    .padding()
                    Divider()
                }
                
                
                
                
                
            }
//            Spacer()
            
        }
        //        Spacer()
        // Get directions button
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                    .frame(height: 48)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                
                Text("Get directions")
                    .foregroundColor(.white)
                    .bold()
            }
            .padding()
        }
        
    }
}

//struct BusinessDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessDetail(business: Business.getTestBusiness())
//    }
//}
