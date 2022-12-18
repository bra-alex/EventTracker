//
//  EventTrackerApp.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

@main
struct EventTrackerApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
