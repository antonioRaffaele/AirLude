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
    
    
    @State private var showingAlert = false
    @State var presentSheet = false
    
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
            
            ZStack{
                localGradient
                .mask(
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 45, alignment: .center)
                        .blur(radius: 10)
                )
                .padding(.top, 20)
                Button(action: {
                    presentSheet = true
                }, label: {
                    Text("Show QR Code")
                        .font(.custom("Avenir-Heavy", size: 20))
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                })
                .foregroundColor(.white)
                .background(localGradient)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .buttonStyle(PlainButtonStyle())
            }
            .frame(height: 100)
        }
        .sheet(isPresented: $presentSheet) {
            VStack(alignment: .center){
                Text("That's your QR Code!")
                    
                Text("Share it with others!")
                    
                let qrCode = Image(uiImage: UIImage(data: selectedEvent.qrCode ?? Data()) ?? UIImage())
                qrCode
                    .resizable()
                    .frame(width: 150, height: 150)
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding(10)
                    .cornerRadius(16)
                Label("Download it here", systemImage: "square.and.arrow.down").foregroundColor(Color.cyan)
                    
            }.presentationDetents([.medium, .large])
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
        .alert("Are you sure?😢",isPresented: $showingAlert){
            Button {
                print("ok")
            } label: {
                Text("Cancel")
            }
            Button {
                self.presentationMode.wrappedValue.dismiss()
                viewModel.deleteEvent(event: selectedEvent)
            } label: {
                Text("Leave").foregroundColor(.red).bold()
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
