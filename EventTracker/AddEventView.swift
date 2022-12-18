//
//  AddEventView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

enum EventType: CaseIterable{
    case birthday, anniversary
    
    var eventType: String{
        switch self {
        case .birthday: return "Birthday"
        case .anniversary: return "Anniversary"
        }
    }
}

struct AddEventView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var eventName = ""
    @State private var eventType = EventType.birthday
    @State private var eventDate = Date()
    
    var body: some View {
        NavigationView {
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
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", role: .destructive) {
                        let events = Events(context: moc)
                        events.eventName = eventName.trimmingCharacters(in: .whitespacesAndNewlines)
                        events.eventType = eventType.eventType
                        events.eventDate = eventDate
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                    .disabled(eventName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
