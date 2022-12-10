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
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var id: UUID?
    @NSManaged public var hasEvents: Event?

    public var wrappedName:String{
        name ?? "Unknown Name"
    }
    
    public var wrappedSurname:String{
        surname ?? "Unknown Surname"
    }
}

extension Student : Identifiable {

}
