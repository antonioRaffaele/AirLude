//
//  AirLudeApp.swift
//  AirLude
//
//  Created by Valerio Mosca on 07/12/22.
//

import SwiftUI

@main
struct AirLudeApp: App {
    @AppStorage("loaded") var firstAccess: Bool = false
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if(firstAccess == false){
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }else{
                EventsPage()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}


