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
            Color.blackGradient
            .mask(
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 120, height: 45, alignment: .center)
                    .blur(radius: 10)
            )
            .padding(.top, 20)
            Button(action: {
                
            }, label: {
                Text(buttonText)
                    .font(.custom("Avenir-Heavy", size: 20))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            })
            .foregroundColor(.white)
            .background(
                Color.blackGradient)
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
