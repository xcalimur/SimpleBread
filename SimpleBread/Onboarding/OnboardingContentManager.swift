//
//  OnboardingContentManager.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/5/22.
//

import Foundation

protocol OnboardingContentManager {
    var limit: Int {get}
    var items: [onboardingItem] {get}
    init(manager: PlistManager)
}

//final means nothing can inherit this class
final class OnboardingContentManagerImpl: OnboardingContentManager {
    
    var limit: Int {
        items.count - 1
    }
    
    var items: [onboardingItem]
    
    init(manager: PlistManager) {
        self.items = manager.convert(plist: "OnboardingContent")
    }
}
