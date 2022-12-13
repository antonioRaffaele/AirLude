//
//  CardViewEvent.swift
//  AirLude
//
//  Created by Valerio Mosca on 13/12/22.
//

import SwiftUI

struct CardViewEvent: View {
    
    var event: Event
    
    var body: some View {
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
