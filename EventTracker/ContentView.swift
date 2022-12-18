//
//  ContentView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            EventsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
