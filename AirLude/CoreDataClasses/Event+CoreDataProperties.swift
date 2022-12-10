//
//  Event+CoreDataProperties.swift
//  AirLude
//
//  Created by Valerio Mosca on 09/12/22.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var category: String?
    @NSManaged public var details: String?
    @NSManaged public var duration: String?
    @NSManaged public var eventDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var qrCode: Data?
    @NSManaged public var title: String?
    @NSManaged public var hasAStudent: Student?
    
    public var wrappedEventTypo: String{
        category ?? "Unknown Card"
    }

}

extension Event : Identifiable {

}
