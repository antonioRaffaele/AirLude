//
//  EventDetails.swift
//  AirLude
//
//  Created by Valerio Mosca on 10/12/22.
//

import SwiftUI

struct EventDetails: View {
    
    var selectedEvent: Event
    
    var body: some View {
        
        VStack(spacing: 10){
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [.orange,.red]),
                    startPoint: .leading,
                  endPoint: .bottom))
                .frame(height: 150)

            HStack{
                Label{
                    Text("Chess Tournament").font(.largeTitle).bold()
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
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .padding()
            }
            
            Spacer()
            
            CustomizedButton(buttonText: "Show QrCode")
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
