//
//  EventInfos.swift
//  AirLude
//
//  Created by Valerio Mosca on 13/12/22.
//

import SwiftUI

struct EventInfos: View {
    
    var selectedEvent: Event
    
    var body: some View {
        
        HStack{
            Label {
                Text("Date").bold()
            } icon: {
                Image(systemName: "calendar")
            }.padding(.leading, 16)
            Spacer()
            Text("\(selectedEvent.eventDate!, formatter: dateFormatter)")
                .padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Category").bold()
            } icon: {
                Image(systemName: "arrowtriangle.down.circle")
            }.padding(.leading, 16)
            Spacer()
            Text("\(selectedEvent.category!)").padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Starting at").bold()
            } icon: {
                Image(systemName: "clock")
            }.padding(.leading, 16)
            Spacer()
            Text("\(selectedEvent.eventDate!, formatter: timeFormatter)").padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Duration").bold()
            } icon: {
                Image(systemName: "hourglass.circle")
            }.padding(.leading, 16)
            Spacer()
            Text(selectedEvent.duration ?? "duration").padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Location").bold()
            } icon: {
                Image(systemName: "location.circle")
            }.padding(.leading, 16)
            Spacer()
            Text(selectedEvent.location ?? "location").padding(.trailing, 20)
        }
        
        HStack{
            Label {
                Text("Created by").bold()
            } icon: {
                Image(systemName: "person.circle")
            }.padding(.leading, 16)
            Spacer()
            Text(selectedEvent.hasAStudent?.nameSurname ?? "author")
                .padding(.trailing, 20)
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

//struct EventInfos_Previews: PreviewProvider {
//    static var previews: some View {
//        EventInfos()
//    }
//}
