//
//  EventDetails.swift
//  AirLude
//
//  Created by Valerio Mosca on 10/12/22.
//

import SwiftUI

struct EventDetails: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: CoreDataViewModel
    
    var selectedEvent: Event
    @State var localIcon: String = ""
    @State var localGradient: LinearGradient = Color.orangeGradient
    
    let indices: IndexSet = [1, 2, 3]
    
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
                .frame(height: 120)
            
            HStack{
                Image(systemName: localIcon)
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding(10)
                    .background {
                        Circle().fill(localGradient)

                    }
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
                //localGradient = Color.orangeGradient
            }else if(selectedEvent.category == "Course"){
                localIcon = "party.popper"
                localGradient = Color.blueGradient
            }else if(selectedEvent.category == "Study Session"){
                localIcon = "books.vertical"
                localGradient = Color.greenGradient
            }else if(selectedEvent.category == "Public Speaking"){
                localIcon = "speaker.wave.2"
                localGradient = Color.purpleGradient
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
                viewModel.deleteEvent(event: selectedEvent)
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