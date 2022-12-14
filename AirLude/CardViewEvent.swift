//
//  CardViewEvent.swift
//  AirLude
//
//  Created by Valerio Mosca on 13/12/22.
//

import SwiftUI

struct CardViewEvent: View {
    
    var event: Event
    
    
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
    
    var body: some View {
        HStack{
            
            VStack{
                
                Image(systemName: localIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25.0,height: 25.0)
                                    .cornerRadius(25)
                                    .padding(6)
                                    .background(localGradient)
                                    .clipShape(Circle())
                                Spacer()
            }
            VStack(alignment: .leading){
                
                Text(event.title ?? "")
                    .bold().font(.system(size: 20))
                
                Text("Date: \(event.eventDate!, formatter: itemFormatter)").bold()
                    .foregroundColor(.white)
                    .padding(6)
                    .padding(.trailing,16)
                    .background(localGradient)
                    .cornerRadius(16)
                    .font(.system(size: 14))
                
                Text("\(event.location!)").bold()
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
                    localGradient = blueGradient
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
