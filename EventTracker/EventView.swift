//
//  EventView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

struct EventView: View {
    @Environment(\.managedObjectContext) var moc
    
    var events: FetchedResults<Events>

    var body: some View {
        List {
            ForEach(events) { event in
                NavigationLink {
                    EditEventView(event: event, eventName: event.eventName!, eventType: event.eventType == EventType.birthday.eventType ? .birthday : .anniversary, eventDate: event.eventDate!)
                        .navigationTitle(event.eventName!)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    HStack{
                        Text(event.eventType == EventType.birthday.eventType ? "🎂" : "🎉")
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading, spacing: 6){
                            Text(event.eventName ?? "N/A")
                                .font(.headline)
                            
                            Text(event.eventDate?.formatted(date: .long, time: .omitted) ?? "N/A")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .onDelete(perform: deleteEvents)
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
