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
    @AppStorage("username") var phoneOwner: String = ""
    @AppStorage("loaded") var firstAccess: Bool = false
    
    let arrStudentModel: [String] = ["Alessio Marino", "Bruna Carolina Baudel de Santana", "Daniel Stafford", "Roberto Pescosolido", "Matteo Fontana", "Sonth Vishal", "Rosa Gioffredo", "Alessandro Capizzi", "Viviana Pipola", "Giada Saccucci", "Andri Hysenllari", "Francesca De Santis", "Fabio Luca Uccella", "William Benigno", "Mattia Ferrara", "Alina Brandizzi", "Audrey Huillard D’Aignaux", "Giacomo Lisita", "Marta Michelle Caliendo", "Masside Dosso", "Alberto Di Ronza", "Alessandro Vinaccia", "Giovanni Maresca", "Pasquale Viscido", "Giulia Alfano", "Leila Najar", "Marco Dell'Isola", "Sarah Ndenbe", "Gilda Perretta", "Giulia Casucci", "Salvatore Amato", "Daniele Patrizio", "Siria Facciolli", "Viacheslav Gorev", "Dolores Pastore", "Andrea Copellino", "Giovanni Mandato", "Riccardo Di Stefano", "Francesca Napolitano", "Ettore Citarella", "Alessandro Corbo", "Antonia Ambrosio", "Rita Marrano", "Fabio Barbato", "Angelo Lepore", "Giuseppe Iodice", "Francesco Iavazzo", "Ivan Narinian", "Madina Malsagova", "Mikhail Borisov", "Ahmed Mgua", "Michele Gatto", "Alessandro Antonino Russo", "Francesco Merola", "Miguel Eduardo Garcia Silva", "Domenico Trotta", "Sonia Di Nicoli", "Gianmarco Gargiulo", "Domenico Buonanno", "Valentino Lasco", "Gabriella Annunziata", "Domenico Piccolo", "Alberto Capone", "Giovanni Michele Napoli", "Aleksandra Nikiforova", "Michele D'Ambra", "Francesca De Rogatis", "Anna Ceglia", "Benedetta Nalbone", "Ferdinando Carbone", "Alfonso Di Monda", "Rossella Bianco", "Sophie Henriette Schweikert", "Valentina Tarantino", "Antonello De Rosa", "Luigi Zito", "Immacolata Garofalo", "Tatiana Karpenko", "Antonio Raffaele Sparano", "Stefania Amatrudi", "Francesco Vezzuto", "Vincenzo Intagliatore", "Chiara De Nisio", "Danilo Cotarella", "Rosaria Maria Ester Piscopo", "Martina Casillo", "Beatriz de Castro Maia Gomes", "Stefano Capizzi", "Antonella Giugliano", "Marco Santopietro", "Giovanni Capuano", "Bruno Vezzuto", "Francesco Di Nardo", "Anna Lambiase", "Federico Di Silvio", "Salvatore De Luca", "Maria Cristina Buono", "Roberto Portolano", "Tania Velluso", "Katia De Lucia", "Vincenza Piccolo", "Annamaria De Michele", "Roberto Gambardella", "Mariavittoria La Barbera", "Emanuele Della Peruta", "Ciro Secondulfo", "Lorenzo Brescanzin", "Bourouiba Kamil", "Walter Galiano", "Nicola Rigoni", "Bryan Sánchez Peralta", "Sabrina Moura dos Santos", "Jonatas Almeida Brisotti", "Stefano Sivo", "Htet Myak Moe Myint Kyal", "Ekaterina Grishina", "Umberto Breglia", "Anja Hysa", "Aleksandr Shapovalov", "Lara De Sena", "Antonia Cacciola", "Tullio Boccardo", "Antonio Palomba", "Ray Edward Kimbler", "Federico Lupotti", "Antonio Giordano", "Leonardo Daniele", "Valerio Mosca", "Serena Palumbo", "Séamus O'Connor", "Vincenzo D'Ambrosio", "Pierpaolo Siciliano", "Valerio Lisita", "Giulio Ammendola", "Simon Bestler", "Eleonora Ballarini", "Alfonso Buonaguro", "Arturo Alfani"]
    
    
    
    var body: some View {
            VStack{
                
                    SearchBar()

                    Button {
                        firstAccess = true
                        EventsPage()
                        print("bonase")
                        
                    } label: {
                        Text("Next")
                    }
                    
                
            }
        .onAppear(){
            if(firstAccess == false){
                for i in 0...arrStudentModel.count - 1 {
                    let newStudent = Student(context: viewContext)
                    print(arrStudentModel[i])
                    newStudent.nameSurname = arrStudentModel[i]
                    newStudent.id = UUID()
                    
                    saveStudent()

                }
            }
        }
    }
    
    enum FormSubmissionError: Error {
            case missingInput
            case anyOtherKindofError
        }
    
//    private func addStudent() throws {
//        guard self.name != "" && self.surname != "" else {throw FormSubmissionError.missingInput}
//        let newStudent = Student(context: viewContext)
//        newStudent.name = self.name
//        newStudent.surname = self.surname
//        newStudent.id = UUID()
//
//        saveStudent()
//    }
    
    private func saveStudent(){
        do {
            try viewContext.save()
                print("Student saved.")
            } catch {
                print(error.localizedDescription)
            }
    }
    
//    func loadStudentsList(studentList: [String]){
//        ForEach(0..<studentList.count, id: \.self) { index in
//            let newStudent = Student(context: viewContext)
//            newStudent.name = studentList[index]
//            newStudent.surname = studentList[index]
//            newStudent.id = UUID()
//        }
//    }
    
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
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
