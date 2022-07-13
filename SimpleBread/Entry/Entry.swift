//
//  Entry.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/15/22.
//

import Foundation
import SwiftUI

struct Entry: Identifiable, Equatable {

    
    var id = UUID()

    var isFavorited = false
    var issaved = false
    var isDone = false
    var captions: [Caption]  = []
    
    var flour = ""
    var water = ""
    var yeast = ""
    var salt = ""
    var butter = ""  
    var folds = ""
    var weather = ""
    
    mutating func saveWidget (type: String, value: String) {
        switch type{
        case "water":
            water = value
        case "flour":
            flour = value
        case "yeast":
            yeast = value
        case "salt":
            salt = value
        case "butter":
            butter = value
        case "folds":
            folds = value
        default:
            print("X")
        }
    }
    
    
    func getFilledProperties() -> [(type: String, amount: String)]{
        
        var properties: [(type: String, amount: String)] = []
        
        if flour != "" {
            properties += [(type: "camera.macro", amount: flour)]
        }
        if water != "" {
            properties += [(type: "drop.fill", amount: water)]
        }
        if yeast != "" {
            properties += [(type: "allergens", amount: yeast)]
        }
        if salt != "" {
            properties += [(type: "staroflife.fill", amount: salt)]
        }
        if butter != "" {
            properties += [(type: "cube", amount: butter)]
        }
        if folds != "" {
            properties += [(type: "arrow.triangle.2.circlepath", amount: folds)]
        }
        
        return properties
    }
    

}
