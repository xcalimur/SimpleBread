//
//  WidgetPicker.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/27/22.
//

import SwiftUI

struct flourPicked: View {
    @State var newEntry: Entry
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var widget = Widget(type: "camera.macro", amount: "")

    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            
            
            VStack{
                
          
                
                HStack{
                    Text("Flour")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                        newEntry.widgets.append(widget)
                        
                        
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 40))
                            .padding()
                            
                    }
                 
                }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue)
                    .frame(width: 400, height: 200, alignment: .center)
                    .overlay(){
                        HStack{
                            Image(systemName: "camera.macro")
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                            
                            TextField("000", text: $widget.amount)
                                .textFieldStyle(.automatic)
                                .padding()
                                .font(.system(size: 80))
                                .multilineTextAlignment(.trailing)
                            
                        }
                    }
             
    
                
                
            }
        }
    }
}

struct waterPicked: View {
    @State var newEntry: Entry
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var widget = Widget(type: "drop", amount: "")

    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            
            
            VStack{
                
          
                
                HStack{
                    Text("Water")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                        newEntry.widgets.append(widget)
                        
                        
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 40))
                            .padding()
                            
                    }
                 
                }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue)
                    .frame(width: 400, height: 200, alignment: .center)
                    .overlay(){
                        HStack{
                            Image(systemName: "drop")
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                            
                            TextField("000", text: $widget.amount)
                                .textFieldStyle(.automatic)
                                .padding()
                                .font(.system(size: 80))
                                .multilineTextAlignment(.trailing)
                            
                        }
                    }
             
    
                
                
            }
        }
    }
}

struct WidgetPicker: View {
    @Environment(\.presentationMode) var presentationMode
    @State var newEntry: Entry
    
    @State private var waterSelected = false
    @State private var flourSelected = false
    @State private var yeastSelected = false
    
    


    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            
            
            VStack{
               
                HStack{
                    Spacer()
                  
                    Button("Dismiss") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
       
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    Button{
                        waterSelected.toggle()
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 100, height: 100)
                                .overlay(){
                                    Image(systemName: "drop")
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            
                        }
                    }
                    .fullScreenCover(isPresented: $waterSelected, content: {waterPicked(newEntry: newEntry)})

                    
                    Spacer()
                    
                    Button{
                        flourSelected.toggle()
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 100, height: 100)
                                .overlay(){
                                    Image(systemName: "camera.macro")
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            
                        }
                    }
                    .fullScreenCover(isPresented: $flourSelected, content: {flourPicked(newEntry: newEntry)})
                    
                    Spacer()
                    Button{
                        yeastSelected.toggle()
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 100, height: 100)
                        }
                    }
                    Spacer()
                    
                }
                .frame(width: 400, height: 750, alignment: .topLeading)
                
                Spacer()
            }
        }
    }
}

struct WidgetPicker_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPicker(newEntry: Entry())
    }
}
