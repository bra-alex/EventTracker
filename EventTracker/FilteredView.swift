//
//  FilteredView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import CoreData
import SwiftUI

struct FilteredView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.eventDate)], predicate: NSPredicate(format: "eventDate >= %@ && eventDate <= %@", Calendar.current.startOfDay(for: Date()) as CVarArg, Calendar.current.startOfDay(for: Date() + 86400) as CVarArg)) var events: FetchedResults<Events>
    
    var body: some View {
        EventView(events: events)
    }
}
