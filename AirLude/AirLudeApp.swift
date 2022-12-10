//
//  AirLudeApp.swift
//  AirLude
//
//  Created by Valerio Mosca on 07/12/22.
//

import SwiftUI

@main
struct AirLudeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


