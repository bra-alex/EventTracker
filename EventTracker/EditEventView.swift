//
//  EditEventView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

struct EditEventView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: []) var events: FetchedResults<Events>
    
    let event: Events
    
    @State var eventName: String
    @State var eventType: EventType
    @State var eventDate: Date
    
    @State private var delete = false
    
    var disableUpdate: Bool{
        eventName == event.eventName && eventType.eventType == event.eventType && eventDate == event.eventDate
    }
    
    var body: some View {
        Form{
            Section {
                TextField("Event name", text: $eventName)
            }
            
            Section{
                Picker("Event Type", selection: $eventType) {
                    ForEach(EventType.allCases, id: \.self) { eventType in
                        Text(eventType.eventType)
                    }
                }
            }
            
            Section{
                DatePicker("Event Date", selection: $eventDate, in: Date()..., displayedComponents: [.date])
            }
            
            Button("Delete", role: .destructive) {
                delete = true
            }
            .buttonStyle(.borderless)
            .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .alert("Delete Event?", isPresented: $delete){
            Button("Delete", role: .destructive, action: deleteEvent)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you sure you want to delete this event?")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Update") {
                    let eventIndex = events.firstIndex(of: self.event)!
                    let event = events[eventIndex]
                    
                    event.eventName = eventName.trimmingCharacters(in: .whitespacesAndNewlines)
                    event.eventType = eventType.eventType
                    event.eventDate = eventDate
                    
                    if moc.hasChanges{
                        try? moc.save()
                    }
                    dismiss()
                }
                .disabled(disableUpdate)
            }
        }
    }
    
    func deleteEvent(){
        moc.delete(event)
        try? moc.save()
        
        dismiss()
    }
}
