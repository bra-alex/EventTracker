//
//  DataController.swift
//  Bookworm
//
//  Created by Don Bouncy on 10/12/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "EventTracker")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
