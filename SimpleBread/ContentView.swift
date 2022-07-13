//
//  ContentView.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/5/22.
//

import SwiftUI

struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: Double

    func path(in rect: CGRect) -> Path {
        // ensure we have at least two corners, otherwise send back an empty path
        guard corners >= 2 else { return Path() }

        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2

        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / Double(corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // we're ready to start with our path now
        var path = Path()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: Double = 0

        // loop over all our points/inner points
        for corner in 0..<corners * 2  {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // move on to the next corner
            currentAngle += angleAdjustment
        }

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}

struct listOfEntries: View {
    
    @EnvironmentObject var items: Entries
    
    var body: some View {
        ForEach(items.entries){ item in
            NavigationLink(destination: PastEntryView(entry: item, index: items.entries.firstIndex(of: item)!, widgets: item.getFilledProperties())) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.orange)
                    .shadow(radius: 10)
                    .frame(width: 300, height: 290, alignment: .center)
                    .padding(.top)
                    .overlay(alignment: .leading){
                            VStack{
                                Image("bread")
                                    .resizable()
                                    .cornerRadius(20)
                                    .frame(width: 300, height: 200)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom,6)
                                    //.offset(y: -20)
                                    .overlay(alignment: .topLeading){
                                        Circle()
                                            .fill(.white)
                                            .shadow(radius: 10)
                                            .frame(width: 60, height: 60, alignment: .topLeading)
                                            .offset(x:-10,y:-10)
                                            .overlay{
                                                VStack{
                                                    Text(item.captions.first?.getMonth() ?? ".")
                                                        .foregroundColor(.gray)
                                                        .font(.subheadline)
                                                        .offset(x: -10, y: -5)
                                                    
                                                    Text(item.captions.first?.getDayOfMonth() ?? "..")
                                                        .foregroundColor(.gray)
                                                        .font(.title)
                                                        .multilineTextAlignment(.center)
                                                        .offset(x: -10, y: -10)
                                                }
                                            }
                                    }
                                    .overlay(alignment: .topTrailing){
                                        Circle()
                                            .fill(.white)
                                            .shadow(radius: 10)
                                            .frame(width: 60, height: 60, alignment: .topLeading)
                                            .offset(x:10,y:-10)
                                            .overlay(){
                                                
                                                Star(corners: 5, smoothness: 0.45)
                                                    .fill(.orange)
                                                    .offset(x: 10, y: -10)
                                                    .frame(width: 35, height: 35, alignment: .center)
                                                
                                            }
                                    }
                                
                                
                                HStack{
                                  
                                    MakeWidgetCapsule(image: "cloud.sun.fill", amount: "\(item.weather)")
                                    
                                    MakeWidgetCapsule(image: "camera.macro", amount: item.flour)
                                    
                                    MakeWidgetCapsule(image: "drop.fill", amount: item.water)
               
                                }
                                
                                HStack{
                                    
                                    MakeWidgetCapsule(image: "allergens", amount: item.yeast)
                                    
                                    MakeWidgetCapsule(image: "arrow.triangle.2.circlepath", amount: item.folds)
                                    
                                    MakeWidgetCapsule(image: "zzz", amount: "1 hr")
                        
                                
                                    
                                    
                                }
                                .padding(.bottom,20)
                                
                                
                            }
                            
                         
                                
                        
                    }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Simple Bread")
            
        }
    }
    
    func MakeWidgetCapsule(image:String,amount:String) -> some View {
        Capsule()
            .fill(.thinMaterial)
            .frame(width: 80, height: 30, alignment: .topLeading)
            .overlay() {
                
                HStack{
                    
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 12, height: 15)
                        .foregroundColor(Color(.black))
                        .padding([.top,.bottom,.leading])
                       
                    
                    Spacer()
                        
                    Text(amount)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                        .padding(.trailing)
                    
                }
                .frame(width: 80, height: 30)

            }
    }
}


struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    @EnvironmentObject var items: Entries
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    
    var body: some View {
        VStack {
            
            NavigationView {
                
                
                ZStack{
                    ScrollView(showsIndicators: false) {
                    VStack{
                        if items.entries.count > 0 { //
                            listOfEntries()
                                .environmentObject(items)
                            }
                        
                        }
                

                    }
                   
                    Spacer()
                    
                    VStack{
                        if let location = locationManager.location {
                            if let weather = weather {
                                Text("")
                            } else {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .task {
                                        do{
                                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                        }catch {
                                            print("Error")
                                        }
                                    }
                            }
                        } else {
                            if locationManager.isLoading{
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                GetLocationView()
                                    .environmentObject(locationManager)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: EntryView(newEntry: Entry(), current: items.entries.count, weather: weather ?? previewWeather).environmentObject(items)) {
                        Capsule()
                                .fill(.orange)
                            .shadow(radius: 10)
                            .frame(width: 320, height: 100, alignment: .center)
                            .overlay(){
                                HStack(alignment: .center, spacing: 0){
                                   Image(systemName: "plus.circle")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .offset(x: -60)
                                    
                                   
                                    
                                    Text("New Bread")
                                        
                                        .foregroundColor(.white)
                                        .offset(x: -20)
                                    
                                }
                            }
                            
                    }
                    //.padding(.horizontal)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Simple Bread")
                    }}
            }
            
        }
        .fullScreenCover(isPresented: .constant(!hasSeenOnboarding), content: {
            
            let plistManager = PlistManagerImpl()
            let onboardingContentManager = OnboardingContentManagerImpl(manager: plistManager)
            OnboardingScreenView(manager: onboardingContentManager) {
                hasSeenOnboarding = true
            }
        })
        
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView()
            .environmentObject(Entries())
            
    }
}
