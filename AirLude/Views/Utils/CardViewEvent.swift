//
//  CardViewEvent.swift
//  AirLude
//
//  Created by Valerio Mosca on 13/12/22.
//

import SwiftUI

struct CardViewEvent: View {
    
    var event: Event
    
    @State var localIcon: String = ""
    @State var localGradient: LinearGradient = Color.orangeGradient
    
    var body: some View {
        HStack{
            
            VStack{
                
                Image(systemName: localIcon)
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding(10)
                    .background {
                        Circle().fill(localGradient)

                    }
                                Spacer()
            }
            VStack(alignment: .leading){
                
                Text(event.title ?? "")
                    .bold().font(.system(size: 20))
                
                Text("Date: \(event.eventDate ?? Date(), formatter: itemFormatter)").bold()
                    .foregroundColor(.white)
                    .padding(6)
                    .padding(.trailing,16)
                    .background(localGradient)
                    .cornerRadius(16)
                    .font(.system(size: 14))
                
                Text("\(event.location ?? "default location")").bold()
                    .foregroundColor(.white)
                    .padding(6)
                    .padding(.trailing,16)
                    //.padding(.leading,16)
                    .background(localGradient)
                    .cornerRadius(16)
                    .font(.system(size: 14))
            }
        }.padding()
            .onAppear(){
                if(event.category == "Tournament"){
                    localIcon  = "flag.checkered.2.crossed"
                    //localGradient = orangeGradient
                }else if(event.category == "Course"){
                    localIcon = "party.popper"
                    localGradient = Color.blueGradient
                }else if(event.category == "Study Session"){
                    localIcon = "books.vertical"
                    localGradient = Color.greenGradient
                }else if(event.category == "Public Speaking"){
                    localIcon = "speaker.wave.2"
                    localGradient = Color.purpleGradient
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

//struct CardViewEvent_Previews: PreviewProvider {
//    static var previews: some View {
//        CardViewEvent()
//    }
//}
