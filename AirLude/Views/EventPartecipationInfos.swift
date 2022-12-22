//
//  EventPartecipationInfos.swift
//  AirLude
//
//  Created by Valerio Mosca on 22/12/22.
//

import SwiftUI

struct EventPartecipationInfos: View {
    
    var scannedEvent: EventJSON
    
    var body: some View {
        HStack{
            Label {
                Text("Date").bold()
            } icon: {
                Image(systemName: "calendar")
            }.padding(.leading, 16)
            Spacer()
            Text("\(scannedEvent.eventDate, formatter: dateFormatter)")
                .padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Category").bold()
            } icon: {
                Image(systemName: "arrowtriangle.down.circle")
            }.padding(.leading, 16)
            Spacer()
            Text(scannedEvent.category).padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Starting at").bold()
            } icon: {
                Image(systemName: "clock")
            }.padding(.leading, 16)
            Spacer()
            Text("\(scannedEvent.eventDate, formatter: timeFormatter)").padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Duration").bold()
            } icon: {
                Image(systemName: "hourglass.circle")
            }.padding(.leading, 16)
            Spacer()
            Text(scannedEvent.duration).padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Location").bold()
            } icon: {
                Image(systemName: "location.circle")
            }.padding(.leading, 16)
            Spacer()
            Text(scannedEvent.location).padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Created by").bold()
            } icon: {
                Image(systemName: "person.circle")
            }.padding(.leading, 16)
            Spacer()
            Text(scannedEvent.student.nameSurname)
                .padding(.trailing, 20)
        }
        
        VStack(spacing: -15){
            Text("Description").font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Text(scannedEvent.details)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .lineLimit(1)
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "HH:mm"
    return formatter
}()

//struct EventPartecipationInfos_Previews: PreviewProvider {
//    static var previews: some View {
//        EventPartecipationInfos()
//    }
//}
