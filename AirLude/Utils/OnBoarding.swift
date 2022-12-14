//
//  SwiftUIView.swift
//  AirLude
//
//  Created by Valerio Mosca on 12/12/22.
//

import SwiftUI

struct OnBoarding: View {
    @AppStorage("username") var username: String = ""
    @AppStorage("loaded") var firstAccess: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var shouldShowOnboarding: Bool
    
    
    @State private var searchText = ""
    @State var selectedItem: String?
    
    let orageGradient = LinearGradient(
        gradient: .init(colors: [Color.orange, Color.red.opacity(0.75)]),
        startPoint: .init(x: -0.33, y: -0.33),
        endPoint: .init(x: 0.66, y: 0.66)
    )

    var body: some View {
        NavigationStack {
            VStack{
                List {
                    ForEach(searchResults, id: \.self) { name in
                        SelectionRow(title: name, selectedItem: $selectedItem)
                    }
                }
                //.background(Color(.systemGroupedBackground))
                .navigationTitle("Welcome student!")
                
                ZStack{
                    LinearGradient(
                        gradient: .init(colors: [Color.orange, Color.red.opacity(0.66)]),
                        startPoint: .init(x: 0.0, y: 0.0),
                        endPoint: .init(x: 0.75, y: 0.75)
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 120, height: 45, alignment: .center)
                            .blur(radius: 10)
                    )
                    .padding(.top, 20)
                    Button(action: {
                        username = selectedItem!
                        firstAccess = true
                        shouldShowOnboarding.toggle()
                        //NavigationLink(destination: EventsPage())
                    }, label: {
                        Text("Get Started!")
                            .font(.custom("Avenir-Heavy", size: 20))
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                    })
                    .foregroundColor(.white)
                    .background(orageGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(height: 100)
            }
            .searchable(text: $searchText)
            .onAppear(){
                //create for the first time the database of student in CoreData
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
    }
    
    let arrStudentModel: [String] = ["Alessio Marino", "Bruna Carolina Baudel de Santana", "Daniel Stafford", "Roberto Pescosolido", "Matteo Fontana", "Sonth Vishal", "Rosa Gioffredo", "Alessandro Capizzi", "Viviana Pipola", "Giada Saccucci", "Andri Hysenllari", "Francesca De Santis", "Fabio Luca Uccella", "William Benigno", "Mattia Ferrara", "Alina Brandizzi", "Audrey Huillard D’Aignaux", "Giacomo Lisita", "Marta Michelle Caliendo", "Masside Dosso", "Alberto Di Ronza", "Alessandro Vinaccia", "Giovanni Maresca", "Pasquale Viscido", "Giulia Alfano", "Leila Najar", "Marco Dell'Isola", "Sarah Ndenbe", "Gilda Perretta", "Giulia Casucci", "Salvatore Amato", "Daniele Patrizio", "Siria Facciolli", "Viacheslav Gorev", "Dolores Pastore", "Andrea Copellino", "Giovanni Mandato", "Riccardo Di Stefano", "Francesca Napolitano", "Ettore Citarella", "Alessandro Corbo", "Antonia Ambrosio", "Rita Marrano", "Fabio Barbato", "Angelo Lepore", "Giuseppe Iodice", "Francesco Iavazzo", "Ivan Narinian", "Madina Malsagova", "Mikhail Borisov", "Ahmed Mgua", "Michele Gatto", "Alessandro Antonino Russo", "Francesco Merola", "Miguel Eduardo Garcia Silva", "Domenico Trotta", "Sonia Di Nicoli", "Gianmarco Gargiulo", "Domenico Buonanno", "Valentino Lasco", "Gabriella Annunziata", "Domenico Piccolo", "Alberto Capone", "Giovanni Michele Napoli", "Aleksandra Nikiforova", "Michele D'Ambra", "Francesca De Rogatis", "Anna Ceglia", "Benedetta Nalbone", "Ferdinando Carbone", "Alfonso Di Monda", "Rossella Bianco", "Sophie Henriette Schweikert", "Valentina Tarantino", "Antonello De Rosa", "Luigi Zito", "Immacolata Garofalo", "Tatiana Karpenko", "Antonio Raffaele Sparano", "Stefania Amatrudi", "Francesco Vezzuto", "Vincenzo Intagliatore", "Chiara De Nisio", "Danilo Cotarella", "Rosaria Maria Ester Piscopo", "Martina Casillo", "Beatriz de Castro Maia Gomes", "Stefano Capizzi", "Antonella Giugliano", "Marco Santopietro", "Giovanni Capuano", "Bruno Vezzuto", "Francesco Di Nardo", "Anna Lambiase", "Federico Di Silvio", "Salvatore De Luca", "Maria Cristina Buono", "Roberto Portolano", "Tania Velluso", "Katia De Lucia", "Vincenza Piccolo", "Annamaria De Michele", "Roberto Gambardella", "Mariavittoria La Barbera", "Emanuele Della Peruta", "Ciro Secondulfo", "Lorenzo Brescanzin", "Bourouiba Kamil", "Walter Galiano", "Nicola Rigoni", "Bryan Sánchez Peralta", "Sabrina Moura dos Santos", "Jonatas Almeida Brisotti", "Stefano Sivo", "Htet Myak Moe Myint Kyal", "Ekaterina Grishina", "Umberto Breglia", "Anja Hysa", "Aleksandr Shapovalov", "Lara De Sena", "Antonia Cacciola", "Tullio Boccardo", "Antonio Palomba", "Ray Edward Kimbler", "Federico Lupotti", "Antonio Giordano", "Leonardo Daniele", "Valerio Mosca", "Serena Palumbo", "Séamus O'Connor", "Vincenzo D'Ambrosio", "Pierpaolo Siciliano", "Valerio Lisita", "Giulio Ammendola", "Simon Bestler", "Eleonora Ballarini", "Alfonso Buonaguro", "Arturo Alfani"]

    var searchResults: [String] {
        if searchText.isEmpty {
            return arrStudentModel
        } else {
            return arrStudentModel.filter { $0.contains(searchText) }
        }
    }
    
    enum FormSubmissionError: Error {
            case missingInput
            case anyOtherKindofError
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

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding(shouldShowOnboarding: .constant(false)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
