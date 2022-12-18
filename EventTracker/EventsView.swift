//
//  EventsView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

struct EventsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var events: FetchedResults<Events>
    
    @State private var addEvent = false
    
    var body: some View {
        List {
            ForEach(events) { event in
                VStack{
                    Text("\(event.eventName ?? "N/A")'s \(event.eventType ?? "N/A")" )
                    Text(event.eventDate?.formatted() ?? "N/A")
                }
            }.onDelete(perform: deleteEvents)
        }
        .navigationTitle("Event Tracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addEvent = true
                } label: {
                    Label("Add Event", systemImage: "plus")
                }

            }
        }
        .sheet(isPresented: $addEvent) {
            AddEventView()
        }
    }
    
    func deleteEvents(at offsets: IndexSet){
        for offset in offsets{
            let event = events[offset]
            
            moc.delete(event)
            
            if moc.hasChanges{
                try? moc.save()
            }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            EventsView()
        }
    }
}
