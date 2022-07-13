//
//  PopupView.swift
//  SimpleBread
//
//  Created by Cami Mata on 7/6/22.
//

import SwiftUI

struct PopupView: View {
    var body: some View {
        HStack {
            icon
            content
        }
        .frame(maxWidth: .infinity)
        .shadow(color: .black, radius: 50)
        .padding()
        .multilineTextAlignment(.center)
        .transition(.move(edge: .top))
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}

private extension PopupView {
    
    var icon: some View {
        Image(systemName: "checkmark.circle")
            .font(.system(size: 50))
            .foregroundColor(.green)
    }
    
    var content: some View {
        Text("Saved")
            .font(.callout)
            .foregroundColor(.gray)
    }
}
