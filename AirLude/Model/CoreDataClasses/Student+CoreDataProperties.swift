//
//  Student+CoreDataProperties.swift
//  AirLude
//
//  Created by Valerio Mosca on 09/12/22.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var email: String?
    @NSManaged public var nameSurname: String?
    @NSManaged public var id: UUID?
    @NSManaged public var hasEvents: Event?
    
}

extension Student : Identifiable {

}
