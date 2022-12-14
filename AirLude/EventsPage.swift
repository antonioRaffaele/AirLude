//
//  ContentView.swift
//  AirLude
//
//  Created by Valerio Mosca on 07/12/22.
//

import SwiftUI
import CoreData

struct EventsPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedSegment = 0
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    @State private var showingSheet = false
    
    @State private var showingAlert = false
    
    var body: some View {
            NavigationView{
                VStack{
                    Picker("Choose the section", selection: $selectedSegment) {
                        Text("Show All").tag(0)
                        Text("Created").tag(1)
                    }.padding()
                        .pickerStyle(.segmented)
                    if(selectedSegment == 1){
                        CreatedEventsSection()
                    }else{
                        ShowAllEventsSection()
                    }
                }
                .alert("Perform an action:",isPresented: $showingAlert){
                    Button {
                        print("")
                    } label: {
                        Text("SCAN")
                    }
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Text("ADD")
                    }.sheet(isPresented: $showingSheet){
                        SheetViewAddEvents()
                    }
                }
                .background(Color(.systemGroupedBackground))
                .navigationTitle("Events")
                .toolbar{
                    ToolbarItem{
                        Button{
                            showingAlert.toggle()
                            //showingSheet.toggle()
                            
                        }label: {
                            Label("Add Item", systemImage: "plus")
                        }
                        .sheet(isPresented: $showingSheet) {
                            SheetViewAddEvents()
                        }
                    }
                }
                .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
                    OnBoarding(shouldShowOnboarding: $shouldShowOnboarding)
                })
            }
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

struct EventsPage_Previews: PreviewProvider {
    static var previews: some View {
        EventsPage().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
