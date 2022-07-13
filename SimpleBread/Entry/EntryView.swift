//
//  EntryView.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/7/22.
//

import SwiftUI

struct EntryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var items: Entries
    
    @State var newEntry: Entry
    
    @State private var caption = Caption()
    
    @State  var current: Int
    
    @State private var tracker = false
    
    @State private var showWidgets = false
    
    @State private var description: String = ""
    
    @State private var widgetPicker = "water"
    
    @State private var inputValue = ""
    
    @State private var showSaved = false
    
    let widgets = ["water","flour","yeast","salt","butter","folds"]
    
    var weather: ResponseBody
    
    var body: some View {
        
        
        ZStack {
  
        
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    
                    ZStack (alignment: .top){
                        if showSaved{
                            PopupView()
                                
                        }
                    }
                        Image ("bread")
                            .resizable()
                            .frame(width: 390, height: 250)
                            .cornerRadius(50)
                            .padding(.bottom,10)
                            
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.thickMaterial)
                            .frame(width: 390, height: 70)
                            .overlay(makeWidgetNavigator())
                        
                        makeWidgetIndicators()

                     
                       RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.orange, lineWidth: 4)
                            //.padding(.top,20)
                            .frame(width: 380, height: 200)
                            .overlay(makeCaptionMaker())
                        
                        Spacer()
                        
                        makePastTextEntryViewer()
                        
                        Spacer()
                                                   
                                
                }
               
            }
            
            Spacer()
            
            VStack {
                Spacer()
                saveAndGoBundle()
            }
        }
        
        
    }
    
        
    func makeCaptionMaker() -> some View {
        VStack{
               
            TextField("Type here ..", text: $caption.description)
                .frame(width: 320, height: 140, alignment: .topLeading)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
              
            
        }
        //.padding(.top, 10)
    }
    
        func saveAndGoBundle() -> some View {
            HStack(alignment: .center) {

                Button("Save"){

                    if !tracker {
                        newEntry.weather = weather.main.feelsLike.roundedDouble() + "°"
                        items.add(entry: newEntry)
                        tracker.toggle()
                    } else {
                        items.entries[items.entries.count - 1] = newEntry
                    }
                    
                    newEntry.issaved = true
                    
                    if caption.description != "" {
                        caption.time = Date.now
                        newEntry.captions.append(caption)
                        caption = Caption ()
                    }
                    
                    withAnimation{
                        showSaved = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation(){
                                self.showSaved = false
                            }
                        }
                    }
                    
                }
               .padding()
               .frame(minWidth: 70, minHeight: 50)
               .background(.orange)
               .foregroundColor(.white)

               .clipShape(Capsule())
            
                Button("Confirm"){
                    
                    if caption.description != "" {
                        caption.time = Date.now
                        newEntry.captions.append(caption)
                        caption = Caption ()
                    }

                    items.entries[items.entries.count - 1] = newEntry
                        newEntry.isDone = true
                        newEntry = Entry()
                        tracker.toggle()
                    presentationMode.wrappedValue.dismiss()
                        
                    }
                   .padding()
                   .frame(minWidth: 100, minHeight: 50)
                   .background(.green)
                   .foregroundColor(.white)
                   .clipShape(Capsule())
                    }
        }
    
        func makePastTextEntryViewer() -> some View {
            VStack {
                if newEntry.captions.count > 0 {
                    ForEach(newEntry.captions.reversed()){ cap in
                        
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.regularMaterial)
                             .frame(width: 390, height: 140)
                             .overlay(){
                                 VStack{
                                     Spacer()
                                     Text(cap.description)
                                         .foregroundColor(.secondary)
                                         .frame(width: 330, height: 70, alignment: .topLeading)
                                         .multilineTextAlignment(.leading)
                                         
                                     Spacer()
                                     
                                     Text("// " + cap.timeInterval())
                                         .font(.caption)
                                         .padding()
                                         .foregroundColor(.secondary)
                                         .frame(width: 330, height: 20, alignment: .leading)
                                         .multilineTextAlignment(.leading)
                                     Spacer()
                                 }
                             }
                             .padding(.top, 10)
                
                        
                        
                    }
                }
            }
        }
    
        func makeWidgetIndicators() -> some View {
            HStack {
                if newEntry.water != "" {
                    MakeViewableWidgets(image: "drop.fill", amount: newEntry.water)
                }
                
                if newEntry.flour != "" {
                    MakeViewableWidgets(image: "camera.macro", amount: newEntry.flour)
                }
                
                if newEntry.salt != "" {
                    MakeViewableWidgets(image: "staroflife.fill", amount: newEntry.salt)
                }
                
                if newEntry.yeast != "" {
                    MakeViewableWidgets(image: "allergens", amount: newEntry.yeast)
                }
                
                if newEntry.butter != "" {
                    MakeViewableWidgets(image: "cube", amount: newEntry.butter)
                }
                
                if newEntry.folds != "" {
                    MakeViewableWidgets(image: "arrow.triangle.2.circlepath", amount: newEntry.folds)
                }
            }
            .padding()
        }
    
    func MakeViewableWidgets(image: String, amount: String) -> some View {
            HStack {
                Menu {
                    Text(amount + " g")
                        
                }label: {
                    Circle()
                        .fill(.gray)
                        .frame(width: 50, height: 50,alignment: .trailing)
                        .overlay(){
                            Image(systemName: image)
                                .foregroundColor(.white)
                        }
                }
                
            }
        }
    
            
                    
        func makeWidgetNavigator() -> some View {
            
            HStack{
                
                Picker("", selection: $widgetPicker) {
                                ForEach(widgets, id: \.self) {
                                    Text($0)
                                        
                                }
                            }
                .background(Capsule()
                        .fill(.orange)
                        .frame(width: 60, height: 40))
                .accentColor(.white)
                    .pickerStyle(MenuPickerStyle())
                    .padding([.leading,.trailing], 30)
                    .padding([.top,.bottom], 25)
                
                Spacer()
                
                TextField("0", text: $inputValue)
                    .background(.thinMaterial)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 150, height: 50)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 20)
                    .keyboardType(.numberPad)
               
                
                
                Button{
                    newEntry.saveWidget(type: widgetPicker, value: inputValue)
                    showWidgets = true
                    inputValue = ""
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .foregroundColor(.orange)
                        .frame(width: 70, height: 70,alignment: .trailing)
                }
                .frame(width: 70, height: 70,alignment: .trailing)
                

                
            }
            .frame(width: 390, height: 70, alignment: .center)
            
        }
           
      
    }


struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(newEntry: Entry(), current: 1, weather: previewWeather)
            .environmentObject(Entries())
    }
}
 

