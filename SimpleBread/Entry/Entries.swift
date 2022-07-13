//
//  Entries.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/16/22.
//

import Foundation

class Entries: ObservableObject {
    @Published var entries: [Entry] = []
    
   
    
    
    func add(entry: Entry){
        entries.append(entry)
    }
    
   
    
}
