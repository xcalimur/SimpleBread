//
//  PastEntryView.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/16/22.
//

import SwiftUI

struct PastEntryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var items: Entries
    
    let entry: Entry
    
    let index: Int
    
    let widgets: [(type: String, amount: String)]

    
    var body: some View {
   
            
        ScrollView(.vertical, showsIndicators: false) {
                VStack {
 
                    Image ("bread")
                        .resizable()
                        .frame(width: 390, height: 250)
                        .cornerRadius(50)
                        //.padding()
                    
                    
                    
                    DisplayWidgets()
                           .padding()
                 
                        
                        
                    Spacer()
                    
                    makePastTextEntryViewer()
                    
            }
        }
        .toolbar(){
            Button{
                items.entries.remove(at: index)
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Image(systemName: "x.circle")
                    .font(.system(size: 25))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.trailing)
            }
        }

    }
    
    func makePastTextEntryViewer() -> some View {
        VStack {
            if entry.captions.count > 0 {
                ForEach(entry.captions){ cap in
                    
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
    
    func DisplayWidgets() -> some View {
        VStack {
            
            if(widgets.count < 3) {
                HStack {
                    
                    ForEach(widgets, id: \.type){ widget in
                        
                        Capsule()
                            .fill(.regularMaterial)
                            .multilineTextAlignment(.center)
                            .frame(width: 120, height: 50, alignment: .topLeading)
                            .overlay(){
                                HStack {
                                    Image(systemName: widget.type)
                                        .padding([.leading,.top,.bottom])
                                    
                                    Spacer()
                                    
                                    Text(widget.amount)
                                        .frame(width: 50, height: 50)
                                        
                                                                            
                                }
                            }
                        
                       
                      
                    }
                    .multilineTextAlignment(.center)
                       
                }
            }else {
                HStack {
                    
                    ForEach(widgets[0...2], id: \.type){ widget in
                        
                        Capsule()
                            .fill(.regularMaterial)
                            .multilineTextAlignment(.center)
                            .frame(width: 120, height: 50, alignment: .topLeading)
                            .overlay(){
                                HStack {
                                    Image(systemName: widget.type)
                                        .padding([.leading,.top,.bottom])
                                    
                                    Spacer()
                                    
                                    Text(widget.amount)
                                        .frame(width: 50, height: 50)
                                        
                                                                            
                                }
                            }
                        
                       
                      
                    }
                    .multilineTextAlignment(.center)
                       
                }
            }
            
            
            if(widgets.count > 3) {
                HStack {
                    
                    ForEach(widgets[3...widgets.count-1], id: \.type){ widget in
                        
                        Capsule()
                            .fill(.regularMaterial)
                            .multilineTextAlignment(.center)
                            .frame(width: 120, height: 50, alignment: .topLeading)
                            .overlay(){
                                HStack {
                                    Image(systemName: widget.type)
                                        .padding([.leading,.top,.bottom])
                                    
                                    Spacer()
                                    
                                    Text(widget.amount)
                                        .frame(width: 50, height: 50)
                                        
                                                                            
                                }
                            }
                        
                       
                      
                    }
                    .multilineTextAlignment(.center)
                       
                }
            }
        }
    }
    
}

struct PastEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PastEntryView(entry: Entry(), index: 1, widgets: [(type: "allergens", amount: "50"),(type: "drop.fill", amount: "50"),(type: "flour", amount: "50"),(type: "flour", amount: "50")])
    }
}

