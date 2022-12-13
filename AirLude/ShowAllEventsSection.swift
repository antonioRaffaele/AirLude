//
//  ShowAllSection.swift
//  AirLude
//
//  Created by Valerio Mosca on 13/12/22.
//

import SwiftUI

struct ShowAllEventsSection: View {
    
    @FetchRequest(
        sortDescriptors: []
    ) var EventsArr: FetchedResults<Event>
    
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

struct ShowAllEventsSection_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllEventsSection()
    }
}
