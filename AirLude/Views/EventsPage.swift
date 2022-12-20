//
//  ContentView.swift
//  AirLude
//
//  Created by Valerio Mosca on 07/12/22.
//

import SwiftUI
import CoreData

struct EventsPage: View {
    @ObservedObject var viewModel: CoreDataViewModel
    //@EnvironmentObject var viewModel: CoreDataViewModel
    
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
                        if let tmp = viewModel.storedCreatedEvent{
                            List{
                                ForEach(tmp) { event in
                                    Section{
                                        NavigationLink{
                                            EventDetails(viewModel: viewModel, selectedEvent: event)
                                        } label: {
                                            CardViewEvent(event: event)
                                        }
                                        
                                    }
                                }
                                    
                            }
                            .listStyle(.insetGrouped)
                        }else{
                            Text("ssssss")
                        }
                    }else{
                        if let tmp = viewModel.storedAllEvent{
                            List{
                                ForEach(tmp) { event in
                                    Section{
                                        NavigationLink{
                                            EventDetails(viewModel: viewModel, selectedEvent: event)
                                        } label: {
                                            CardViewEvent(event: event)
                                        }
                                        
                                    }
                                }
                            }
                            .listStyle(.insetGrouped)
                        }else{
                            Text("ehehaehahe")
                        }
                    }
                }
                .alert("How to you want to add a new event?🤓",isPresented: $showingAlert){
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
                        EventAddSheetView(viewModel: viewModel)
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
                            EventAddSheetView(viewModel: viewModel)
                        }
                    }
                }
                .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
                    OnBoarding(viewModel: viewModel, shouldShowOnboarding: $shouldShowOnboarding)
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
        EventsPage(viewModel: CoreDataViewModel())
    }
}
