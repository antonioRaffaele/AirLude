//
//  EventPartecipation.swift
//  AirLude
//
//  Created by Valerio Mosca on 22/12/22.
//

import SwiftUI

struct EventPartecipation: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: CoreDataViewModel
    
    var scannedEvent: EventJSON
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
                    Text(scannedEvent.title).font(.largeTitle).bold()
                } icon:{
                    //Image("")
                }
                Spacer()
            }.padding(16)
            
            EventPartecipationInfos(scannedEvent: scannedEvent)
            
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
        .onAppear(){
            if(scannedEvent.category == "Tournament"){
                localIcon  = "flag.checkered.2.crossed"
                //localGradient = Color.orangeGradient
            }else if(scannedEvent.category == "Course"){
                localIcon = "party.popper"
                localGradient = Color.blueGradient
            }else if(scannedEvent.category == "Study Session"){
                localIcon = "books.vertical"
                localGradient = Color.greenGradient
            }else if(scannedEvent.category == "Public Speaking"){
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

//struct EventDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetails()
//    }
//}

