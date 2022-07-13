//
//  OnboardingScreenView.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/5/22.
//

import SwiftUI

struct OnboardingScreenView: View {
    
    let manager: OnboardingContentManager
    let handler: OnboardingGetStartedAction
    @State private var selected = 0
    
    init(manager: OnboardingContentManager, handler: @escaping OnboardingGetStartedAction) {
        self.manager = manager
        self.handler = handler
    }
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(manager.items.indices) {index in
                OnboardingView(item: manager.items[index], limit: manager.limit, index: $selected, handler: handler)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreenView(manager: OnboardingContentManagerImpl(manager: PlistManagerImpl())) {}
    }
}
