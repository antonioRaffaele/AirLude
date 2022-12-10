//
//  ContentView.swift
//  test2
//
//  Created by Valerio Mosca on 09/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var name: String = ""
    @State private var surname: String = ""
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(){
                    TextField("Name" ,
                              text : $name)
                    
                    TextField("Surname" ,
                              text : $surname)
                }
                
                Section(){
                    Button {
                        do{
                            try
                            addStudent()
                            //EventsPage()
                        }catch{
                            print("Missing fields")
                        }
                        
                    } label: {
                        Text("Click to Save and Next")
                    }
                    
                }
            }
        }
    }
    
    enum FormSubmissionError: Error {
            case missingInput
            case anyOtherKindofError
        }
    
    private func addStudent() throws {
        guard self.name != "" && self.surname != "" else {throw FormSubmissionError.missingInput}
        let newStudent = Student(context: viewContext)
        newStudent.name = self.name
        newStudent.surname = self.surname
        newStudent.id = UUID()
        
        saveStudent()
        
        NavigationLink{
            EventsPage(selectedStudent: newStudent)
        }label:{
            Text("")
        }
    }
    
    private func saveStudent(){
        do {
            try viewContext.save()
                print("Student saved.")
            } catch {
                print(error.localizedDescription)
            }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}




////
////  ContentView.swift
////  AirLude
////
////  Created by Valerio Mosca on 07/12/22.
////
//
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: []
//    ) var studentsArr: FetchedResults<Student>
//
//    @State private var name: String
//    @State private var surname: String
//
//    var selectedStudent : Student
//
//
//    var body: some View {
//        VStack{
//            Spacer()
//
//            List{
//                Section(){
//
//                    TextField("Event Title" ,
//                              text : $name)
//
//                    TextField("Event Description" ,
//                              text : $surname)
//                }
//                Section(){
//                    ForEach(studentsArr) { student in
//
//                        VStack(alignment: .leading){
//                            Text("\(student.name!) \(student.surname!)")
//                                .bold()
//                                .lineLimit(1)
//                                .font(.system(size: 20))
//
//                        }.padding(.leading,10)
//                    }
//
//
//                }
//                Section{
//                    Button {
//                        EventsPage(selectedStudent: selectedStudent)
//                    } label: {
//                        Text("Next")
//                    }
//                }
//            }
//        }
//    }
//    enum FormSubmissionError: Error {
//        case missingInput
//        case anyOtherKindofError
//    }
//
//    private mutating func addStudent() throws {
//        guard self.name != "" && self.surname != "" else {throw FormSubmissionError.missingInput}
//        let newStudent = Student(context: viewContext)
//        newStudent.name = self.name
//        newStudent.surname = self.surname
//        newStudent.id = UUID()
//
//        //self.selectedStudent = newStudent funziona????
//
//        saveStudent()
//    }
//
//    private func saveStudent(){
//        do {
//            try viewContext.save()
//            print("Profile saved.")
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    private let itemFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.dateFormat = "dd/MM/yyyy"
//        return formatter
//    }()
//}
//
//
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
