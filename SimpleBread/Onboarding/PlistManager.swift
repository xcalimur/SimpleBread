//
//  PlistManager.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/5/22.
//

import Foundation

protocol PlistManager {
    func convert(plist fileName: String) -> [onboardingItem]
}

struct PlistManagerImpl: PlistManager {
    func convert(plist fileName: String) -> [onboardingItem] {
        //guard because if anything fails it will return an empty array
        //eaiser then using multiple if statements
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let items = try? PropertyListDecoder().decode([onboardingItem].self, from: data) else {
            return []
        }
                
        
        return items
    }
}
