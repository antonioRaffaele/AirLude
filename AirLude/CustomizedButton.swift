//
//  CustomizedButton.swift
//  AirLude
//
//  Created by Valerio Mosca on 13/12/22.
//

import SwiftUI

struct CustomizedButton: View {
    
    var buttonText: String
    
    var body: some View {
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
                Text(buttonText)
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

struct CustomizedButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomizedButton(buttonText: "")
    }
}
