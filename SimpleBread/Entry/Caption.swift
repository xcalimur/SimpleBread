//
//  Caption.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/15/22.
//

import Foundation
import SwiftUI

struct Caption: Hashable, Codable, Identifiable {
    
    var id = UUID()
    var time = Date.now
    var description = ""
    
    func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: time)
        let subString = month.prefix(3)
        let mon = String(subString)
        return mon
    }
    
    func getDayOfMonth() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: time)
        return day
    }
    
    func timeInterval() -> String {
        let date = Date.now
        let cal =  Calendar.current.dateComponents([.hour], from: time, to: date).hour ?? 0
        
        var str = "no time"
        
        if cal == 0 {
            
            let cal2 = Calendar.current.dateComponents([.minute], from: time, to: date).minute ?? 0
            
            str = String(cal2) + " mins ago"

            
        } else {
            str = String(cal) + " hours ago"
        }
        return str
    }
}
