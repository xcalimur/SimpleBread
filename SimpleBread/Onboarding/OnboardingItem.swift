//
//  OnboardingItem.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/5/22.
//

import Foundation

struct onboardingItem: Codable, Identifiable {
    var id = UUID()
    var title: String?
    var content: String?
    var sfSymbol: String?
    
    enum CodingKeys: String, CodingKey {
        case title, content, sfSymbol
    }
    
    
    //dummy content if it's nil
    init(title: String? = nil, content: String? = nil, sfSymbol: String? = nil) {
        self.title = title
        self.content = content
        self.sfSymbol = sfSymbol
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try container.decode(String?.self, forKey: .title)
            self.content = try container.decode(String?.self, forKey: .content)
            self.sfSymbol = try container.decode(String?.self, forKey: .sfSymbol)
        } catch {
            print(error)
        }
    }
    
}
