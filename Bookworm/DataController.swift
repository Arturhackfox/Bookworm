//
//  DataController.swift
//  Bookworm
//
//  Created by Arthur Sh on 08.12.2022.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    var container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Failed to load core data there was an error \(error.localizedDescription)")
            }
        }
    }
}
