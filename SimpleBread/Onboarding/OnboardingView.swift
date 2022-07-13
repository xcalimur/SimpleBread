//
//  OnboardingView.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/5/22.
//

import SwiftUI

typealias OnboardingGetStartedAction = () -> Void

struct OnboardingView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    let item: onboardingItem
    let limit: Int
    let handler: OnboardingGetStartedAction
    @Binding var index:Int
    
    init( item: onboardingItem, limit:Int, index: Binding<Int>, handler: @escaping OnboardingGetStartedAction) {
     
        self.item = item
        self.limit = limit
        self._index = index
        self.handler = handler
        
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Image(systemName: item.sfSymbol ?? "")
                .padding(.bottom, 50)
                .font(.system(size: 120, weight: .bold))
            
            Text(item.title ?? "")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 2)
                .foregroundColor(.primary)
            
            Text(item.content ?? "")
                .font(.system(size: 12, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
                .foregroundColor(.secondary)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                handler()}
                
                , label: {
                Text("Get Started")
            })
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 50)
            .opacity(index == limit ? 1 : 0)
            .allowsHitTesting(index == limit)
            .animation(.easeInOut, value: 0.25)
        }
        .padding(.bottom, 150)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(item: onboardingItem(title: "dummy", content: "dummy", sfSymbol: "heart"), limit: 0, index: .constant(0)) {}
    }
}
