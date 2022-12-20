//
//  Event.swift
//  AirLude
//
//  Created by Valerio Mosca on 20/12/22.
//

import Foundation

struct EventJSON : Codable{
    var id: UUID
    var location: String
    var eventDate: Date
    var duration: String
    var details: String
    var category: String
    var title: String
    var student: StudentJSON
    //var qrCode: Image
    
    init(id: UUID, location: String, eventDate: Date, duration: String, details: String, category: String, title: String, student: StudentJSON) {
        self.id = id
        self.location = location
        self.eventDate = eventDate
        self.duration = duration
        self.details = details
        self.category = category
        self.title = title
        self.student = student
    }
    
}
