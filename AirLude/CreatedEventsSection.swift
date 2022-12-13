//
//  CreatedEventSection.swift
//  AirLude
//
//  Created by Valerio Mosca on 13/12/22.
//

import SwiftUI

struct CreatedEventsSection: View {
    
    private var user = UserDefaults.standard.string(forKey: "username")
    
    @FetchRequest(
        sortDescriptors: []
    ) var EventsArr: FetchedResults<Event>
    
    //serve per creare un array di eventi creati dallo user
    var events :[Event] {
        EventsArr
            .filter({ event in
                //print(doc.hasAProfile?.id ?? Profile(), selectedProfile.id ?? Profile())
                return event.hasAStudent?.nameSurname == user
            })
    }
    
    var body: some View {
        List{
            ForEach(EventsArr) { event in
                Section{
                    NavigationLink{
                        EventDetails(selectedEvent: event)
                    } label: {
                        CardViewEvent(event: event)
                    }
                    
                }
            }
        }
        .listStyle(.insetGrouped)
            
    }
}

struct CreatedEventsSection_Previews: PreviewProvider {
    static var previews: some View {
        CreatedEventsSection()
    }
}
