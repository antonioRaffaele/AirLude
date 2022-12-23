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
    @Published var studentTmp: Student?
    
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
        let sectionSortDescriptor = NSSortDescriptor(key: "eventDate", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
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
        let sectionSortDescriptor = NSSortDescriptor(key: "eventDate", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
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
    
    func getStudentJson() -> StudentJSON{
        let request = NSFetchRequest<Student>(entityName: "Student")
        //        request.predicate = NSPredicate(format: "hasAStudent?.nameSurname == %@",user!)
        do{
            storedStudent = try container.viewContext.fetch(request).filter({ student in
                student.nameSurname == user
            })
            
        }catch let error{
            print("ERROR FETCHING! \(error)")
        }
        
        let student: StudentJSON = StudentJSON(id: storedStudent.first?.id ?? UUID(), nameSurname: user ?? "user default")
        return student
    }
    
    func getStudent(userIn: String){
        let request = NSFetchRequest<Student>(entityName: "Student")
        //        request.predicate = NSPredicate(format: "hasAStudent?.nameSurname == %@",user!)
        do{
            storedStudent = try container.viewContext.fetch(request).filter({ student in
                student.nameSurname == userIn
            })
            studentTmp = storedStudent.first
        }catch let error{
                print("ERROR FETCHING! \(error)")
        }
    }
    
    func addEvent(titleIn: String, detailsIn: String, eventDateIn: Date, durationIn: String, categoryIn: String, locationIn: String, idIn: UUID, qrCodeIn: Data, userIn: String){
            
        getStudent(userIn: userIn)
            
        let newEvent = Event(context: container.viewContext)
            
        newEvent.title = titleIn
        newEvent.details = detailsIn
        newEvent.eventDate = eventDateIn
        newEvent.duration = durationIn
        newEvent.category = categoryIn
        newEvent.location = locationIn
        newEvent.id = idIn
        newEvent.qrCode = qrCodeIn
        
        print(storedStudent.first?.nameSurname ?? "")
        newEvent.hasAStudent = studentTmp
        
        saveContext()
        fetchEventsArray()
    }
    
    func addStudent(nameSurnameIn: String){
        let newStudent = Student(context: container.viewContext)
        
        newStudent.nameSurname = nameSurnameIn
        newStudent.id = UUID()
        
        saveContext()
    }
    
    func saveContext(){
        do {
            try container.viewContext.save()
            print("Context saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}
