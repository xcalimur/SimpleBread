//
//  SwiftUIView.swift
//  SimpleBread//
//  Created by Cami Mata on 6/21/22.
//

import SwiftUI

struct SwiftUIView: View {
    @State var here = ""
    
    var body: some View {
        TextField("type here", text: $here)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
