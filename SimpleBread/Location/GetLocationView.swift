//
//  GetLocationView.swift
//  SimpleBread
//
//  Created by Cami Mata on 7/7/22.
//

import SwiftUI
import CoreLocationUI

struct GetLocationView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            VStack(spacing: 20) {
                
                Text("Welcome")
                    .bold().font(.title)
                
                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame( maxWidth: .infinity, maxHeight:.infinity)
    }
}

struct GetLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GetLocationView()
    }
}
