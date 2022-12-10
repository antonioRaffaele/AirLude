//
//  EventDetails.swift
//  AirLude
//
//  Created by Valerio Mosca on 10/12/22.
//

import SwiftUI

struct EventDetails: View {
    var body: some View {
        VStack{
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [.orange,.red]),
                    startPoint: .leading,
                  endPoint: .bottom))
                .frame(height: 150)
                //.fill(.orange.gradient).frame(height: 150)
            HStack{
                //icona
                Text("Chess Tournament")
                Spacer()
            }.padding(16)
            
            HStack{
                //icona
                Text("Chess Tournament")
                Spacer()
            }.padding(8)
            
            Spacer()
            
        }
    }
}

struct EventDetails_Previews: PreviewProvider {
    static var previews: some View {
        EventDetails()
    }
}
