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
    
    var selectedStudent : Student
    
    @FetchRequest(
        sortDescriptors: []
    ) var EventsArr: FetchedResults<Event>
    
//    var events :[Event] {
//        EventsArr
//            .filter({ event in
//                //print(doc.hasAProfile?.id ?? Profile(), selectedProfile.id ?? Profile())
//                return event.hasAStudent?.id == selectedStudent.id
//            })
//    }
    
    @State private var showingSheet = false

    var body: some View {
        VStack(spacing: 10){
            List{
                ForEach(EventsArr) { event in
                    Section{
                        NavigationLink{
                            //EventDetails(selectedCard: event)
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
                                    Text("Card Number:")
                                        .font(.system(size: 13))

                                    Text("Date: \(event.eventDate!, formatter: itemFormatter)")
                                        .font(.system(size: 13))

                                }
                            }
                        }

                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Cards")
            .toolbar{
                ToolbarItem{
                    Button{
                        showingSheet.toggle()

                    }label: {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        SheetViewAddEvents(selectedStudent: selectedStudent)
                    }
                }
            }
            .onAppear {
                //print(events)
            }
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
        EventsPage(selectedStudent: Student()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
