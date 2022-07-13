//
//  SimpleBreadApp.swift
//  SimpleBread
//
//  Created by Cami Mata on 6/5/22.
//

import SwiftUI

@main
struct SimpleBreadApp: App {
    @StateObject var items : Entries

// init() {   }   might be needed here if the StateObject is not initialised

  init() {
      let items = Entries()
      _items = StateObject(wrappedValue: items)
 }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(items)
        }
    }
}
