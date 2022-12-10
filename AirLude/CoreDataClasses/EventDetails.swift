//
//  EventDetails.swift
//  AirLude
//
//  Created by Valerio Mosca on 10/12/22.
//

import SwiftUI

struct EventDetails: View {
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
            
            HStack{
                Label {
                    Text("Date").bold()
                } icon: {
                    Image(systemName: "calendar")
                }.padding(.leading, 16)
                Spacer()
                Text("Data").padding(.trailing, 20)
            }
            
            HStack{
                Label {
                    Text("Category").bold()
                } icon: {
                    Image(systemName: "arrowtriangle.down.circle")
                }.padding(.leading, 16)
                Spacer()
                Text("Data").padding(.trailing, 20)
            }
            
            HStack{
                Label {
                    Text("Starting at").bold()
                } icon: {
                    Image(systemName: "clock")
                }.padding(.leading, 16)
                Spacer()
                Text("Data").padding(.trailing, 20)
            }
            
            HStack{
                Label {
                    Text("Duration").bold()
                } icon: {
                    Image(systemName: "hourglass.circle")
                }.padding(.leading, 16)
                Spacer()
                Text("Data").padding(.trailing, 20)
            }
            
            HStack{
                Label {
                    Text("Location").bold()
                } icon: {
                    Image(systemName: "location.circle")
                }.padding(.leading, 16)
                Spacer()
                Text("Data").padding(.trailing, 20)
            }
            
            VStack(spacing: -15){
                Text("Description").font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .padding()
            }
            
            Spacer()
            
            ZStack{
                LinearGradient(
                    gradient: .init(colors: [Color.orange, Color.red.opacity(0.66)]),
                    startPoint: .init(x: 0.0, y: 0.0),
                    endPoint: .init(x: 0.75, y: 0.75)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 45, alignment: .center)
                        .blur(radius: 10)
                )
                .padding(.top, 20)
                Button(action: {}, label: {
                    Text("Show QrCode")
                        .font(.custom("Avenir-Heavy", size: 20))
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                })
                .foregroundColor(.white)
                .background(
                    LinearGradient(
                        gradient: .init(colors: [Color.orange, Color.red.opacity(0.75)]),
                        startPoint: .init(x: -0.33, y: -0.33),
                        endPoint: .init(x: 0.66, y: 0.66)
                    ))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .buttonStyle(PlainButtonStyle())
            }
            .frame(height: 100)
        }
    }
}

struct EventDetails_Previews: PreviewProvider {
    static var previews: some View {
        EventDetails()
    }
}
