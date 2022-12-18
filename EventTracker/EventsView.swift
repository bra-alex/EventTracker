//
//  EventsView.swift
//  EventTracker
//
//  Created by Don Bouncy on 18/12/2022.
//

import SwiftUI

struct EventsView: View {
    
    @State private var addEvent = false
    @State private var viewToday = false
    
    var body: some View {
        Group{
            if viewToday{
                FilteredView()
            } else {
                UnfilteredView()
            }
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewToday.toggle()
                } label: {
                    Label("Today", systemImage: viewToday ? "calendar.circle.fill" : "calendar")
                        .animation(.easeInOut, value: viewToday)
                }
            }
        }
        .sheet(isPresented: $addEvent) {
            AddEventView()
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
