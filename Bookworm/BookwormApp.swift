//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Arthur Sh on 08.12.2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
