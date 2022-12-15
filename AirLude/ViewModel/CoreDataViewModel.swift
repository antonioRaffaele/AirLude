//
//  CoreDataManager.swift
//  AirLude
//
//  Created by Valerio Mosca on 15/12/22.
//

import Foundation
import CoreData
import Combine

class CoreDataViewModel: ObservableObject{
    
    private var user = UserDefaults.standard.string(forKey: "username")
    
    let container: NSPersistentContainer
    @Published var storedStudent: [Student] = []
    @Published var storedCreatedEvent:[Event]?
    @Published var storedAllEvent:[Event]?
    
    init(){
        container = NSPersistentContainer(name: "AirLude")
        container.loadPersistentStores{description, error in
            if let error = error{
                print("Error Loading \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        fetchEventsArray()
        
    }
    
    func fetchEventsArray() {
        fetchAllEvent()
        fetchCreatedEvent()
    }
    
    
    func fetchAllEvent(){
        let request = NSFetchRequest<Event>(entityName: "Event")
        do{
            storedAllEvent = try container.viewContext.fetch(request)
        }catch let error{
            print("ERROR FETCHING! \(error)")
        }
    }
    
    func fetchAllStudent(){
        let request = NSFetchRequest<Student>(entityName: "Student")
        //        request.predicate = NSPredicate(format: "hasAStudent?.nameSurname == %@",user!)
        do{
            storedStudent = try container.viewContext.fetch(request)
        }catch let error{
            print("ERROR FETCHING! \(error)")
        }
    }
    
    func fetchCreatedEvent(){
        let request = NSFetchRequest<Event>(entityName: "Event")
        //        request.predicate = NSPredicate(format: "hasAStudent?.nameSurname == %@",user!)
        do{
            storedCreatedEvent = try container.viewContext.fetch(request).filter({ event in
                event.hasAStudent?.nameSurname == user
            })
        }catch let error{
            print("ERROR FETCHING! \(error)")
        }
    }
    
    func deleteEvent(event: Event) {
        container.viewContext.delete(event)
        saveContext()
        fetchAllEvent()
    }
    
    func addEvent(titleIn: String, detailsIn: String, eventDateIn: Date, durationIn: String, categoryIn: String, locationIn: String){
        
        let request = NSFetchRequest<Student>(entityName: "Student")
        //        request.predicate = NSPredicate(format: "hasAStudent?.nameSurname == %@",user!)
        do{
            storedStudent = try container.viewContext.fetch(request).filter({ student in
                student.nameSurname == user
            })
        }catch let error{
            print("ERROR FETCHING! \(error)")
        }
        
        let newEvent = Event(context: container.viewContext)
        
        newEvent.title = titleIn
        newEvent.details = detailsIn
        newEvent.eventDate = eventDateIn
        newEvent.duration = durationIn
        newEvent.category = categoryIn
        newEvent.location = locationIn
        newEvent.id = UUID()
        newEvent.hasAStudent = storedStudent.first
        
        saveContext()
        fetchAllEvent()
    }
    
    func saveContext(){
        do {
            try container.viewContext.save()
            print("Event saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}
