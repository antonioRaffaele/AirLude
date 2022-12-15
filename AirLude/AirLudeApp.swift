//
//  AirLudeApp.swift
//  AirLude
//
//  Created by Valerio Mosca on 07/12/22.
//

import SwiftUI

@main
struct AirLudeApp: App {
    @StateObject var viewModel = CoreDataViewModel()
    @AppStorage("loaded") var firstAccess: Bool = false
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EventsPage(viewModel: viewModel)
//                .onAppear {
//                viewModel.fetchAllEvent()
//                viewModel.fetchCreatedEvent()
            }
        }
    }



