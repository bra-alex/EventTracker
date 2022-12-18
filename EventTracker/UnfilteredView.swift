//
//  UnfilteredView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

struct UnfilteredView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.eventDate)]) var events: FetchedResults<Events>
    
    var body: some View {
        EventView(events: events)
    }
}
