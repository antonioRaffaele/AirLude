//
//  EventDetails.swift
//  AirLude
//
//  Created by Valerio Mosca on 10/12/22.
//

import SwiftUI

struct EventDetails: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var selectedEvent: Event
    
    let indices: IndexSet = [1, 2, 3]
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    
    @FetchRequest(
        sortDescriptors: []
    ) var event: FetchedResults<Event>
    
    //serve per creare un array di eventi creati dallo user
    var event2 :[Event] {
        event
            .filter({ event in
                //print(doc.hasAProfile?.id ?? Profile(), selectedProfile.id ?? Profile())
                return event.id == selectedEvent.id
            })
    }
    
    
    var body: some View {
        
        VStack(spacing: 10){
            Rectangle()
                .fill(localGradient)
                .frame(height: 150)
            
            HStack{
                Image(systemName: localIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25.0,height: 25.0)
                                    .cornerRadius(25)
                                    .padding(6)
                                    .background(localGradient)
                                    .clipShape(Circle())
                Label{
                    Text(selectedEvent.title ?? "").font(.largeTitle).bold()
                } icon:{
                    //Image("")
                }
                Spacer()
            }.padding(16)
            
            EventInfos(selectedEvent: selectedEvent)
            
            VStack(spacing: -15){
                Text("Description").font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text(selectedEvent.details ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .lineLimit(1)
            }
            
            Spacer()
            
            CustomizedButton(buttonText: "Show QrCode")
        }
        .onAppear(){
            if(selectedEvent.category == "Tournament"){
                localIcon  = "flag.checkered.2.crossed"
                //localGradient = orangeGradient
            }else if(selectedEvent.category == "Course"){
                localIcon = "party.popper"
                localGradient = blueGradient
            }
        }
        .alert("Perform an action:",isPresented: $showingAlert){
            Button {
                print("ok")
            } label: {
                Text("Cancel")
            }
            Button {
                self.presentationMode.wrappedValue.dismiss()
                deleteItem(offsets: indices)
            } label: {
                Text("Leave").foregroundColor(.red)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Button{
                        showingAlert.toggle()
                    }label: {
                        Text("Leave Event").foregroundColor(Color(.red))
                    }
                }
            }
    }
    let blueGradient = LinearGradient(
        gradient: .init(colors: [Color.cyan, Color.blue.opacity(0.75)]),
        startPoint: .init(x: -0.33, y: -0.33),
        endPoint: .init(x: 0.66, y: 0.66)
    )
    
    @State var localIcon: String = ""
    @State var localGradient: LinearGradient = LinearGradient(
        gradient: .init(colors: [Color.orange, Color.red.opacity(0.75)]),
        startPoint: .init(x: -0.33, y: -0.33),
        endPoint: .init(x: 0.66, y: 0.66)
    )
    
    private func deleteItem(offsets: IndexSet) {
        
            //offsets.map { event2[$0] }.forEach(viewContext.delete)
        for event in event2{
            viewContext.delete(event)
        }
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        
    }
    
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

//struct EventDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetails()
//    }
//}
