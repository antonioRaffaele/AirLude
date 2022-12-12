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
   
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    @State private var showingSheet = false
    private var user = UserDefaults.standard.string(forKey: "username")
    
    @FetchRequest(
        sortDescriptors: []
    ) var EventsArr: FetchedResults<Event>
    
    //serve per creare un array di eventi creati dallo user
    var events :[Event] {
        EventsArr
            .filter({ event in
                //print(doc.hasAProfile?.id ?? Profile(), selectedProfile.id ?? Profile())
                return event.hasAStudent?.nameSurname == user
            })
    }
    
    var body: some View {
        VStack(spacing: 10){
            NavigationView{
                
                List{
                    ForEach(EventsArr) { event in
                        Section{
                            NavigationLink{
                                EventDetails(selectedEvent: event)
                            } label: {
                                HStack{
                                    
                                    Image("party.popper")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70.0,height: 70.0)
                                        .clipped()
                                        .cornerRadius(50)
                                        .padding(.leading, 14)
                                    
                                    
                                    VStack(alignment: .leading){
                                        Text(event.title ?? "")
                                            .bold().font(.system(size: 17))
                                        
                                        Text("Prova")
                                            .foregroundColor(.primary)
                                            .font(.largeTitle)
                                            .padding()
                                            .background(.pink.opacity(0.2))
                                            .clipShape(Capsule())
                                        
                                        Text("Date: \(event.eventDate!, formatter: itemFormatter)")
                                            .font(.system(size: 13))
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Events")
                .toolbar{
                    ToolbarItem{
                        Button{
                            showingSheet.toggle()
                            
                        }label: {
                            Label("Add Item", systemImage: "plus")
                        }
                        .sheet(isPresented: $showingSheet) {
                            SheetViewAddEvents()
                        }
                    }
                }
            }.fullScreenCover(isPresented: $shouldShowOnboarding, content: {
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
