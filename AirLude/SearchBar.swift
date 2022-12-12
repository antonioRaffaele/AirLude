//
//  SwiftUIView.swift
//  AirLude
//
//  Created by Valerio Mosca on 12/12/22.
//

import SwiftUI

struct SearchBar: View {
    let arrStudentModel: [String] = ["Alessio Marino", "Bruna Carolina Baudel de Santana", "Daniel Stafford", "Roberto Pescosolido", "Matteo Fontana", "Sonth Vishal", "Rosa Gioffredo", "Alessandro Capizzi", "Viviana Pipola", "Giada Saccucci", "Andri Hysenllari", "Francesca De Santis", "Fabio Luca Uccella", "William Benigno", "Mattia Ferrara", "Alina Brandizzi", "Audrey Huillard D’Aignaux", "Giacomo Lisita", "Marta Michelle Caliendo", "Masside Dosso", "Alberto Di Ronza", "Alessandro Vinaccia", "Giovanni Maresca", "Pasquale Viscido", "Giulia Alfano", "Leila Najar", "Marco Dell'Isola", "Sarah Ndenbe", "Gilda Perretta", "Giulia Casucci", "Salvatore Amato", "Daniele Patrizio", "Siria Facciolli", "Viacheslav Gorev", "Dolores Pastore", "Andrea Copellino", "Giovanni Mandato", "Riccardo Di Stefano", "Francesca Napolitano", "Ettore Citarella", "Alessandro Corbo", "Antonia Ambrosio", "Rita Marrano", "Fabio Barbato", "Angelo Lepore", "Giuseppe Iodice", "Francesco Iavazzo", "Ivan Narinian", "Madina Malsagova", "Mikhail Borisov", "Ahmed Mgua", "Michele Gatto", "Alessandro Antonino Russo", "Francesco Merola", "Miguel Eduardo Garcia Silva", "Domenico Trotta", "Sonia Di Nicoli", "Gianmarco Gargiulo", "Domenico Buonanno", "Valentino Lasco", "Gabriella Annunziata", "Domenico Piccolo", "Alberto Capone", "Giovanni Michele Napoli", "Aleksandra Nikiforova", "Michele D'Ambra", "Francesca De Rogatis", "Anna Ceglia", "Benedetta Nalbone", "Ferdinando Carbone", "Alfonso Di Monda", "Rossella Bianco", "Sophie Henriette Schweikert", "Valentina Tarantino", "Antonello De Rosa", "Luigi Zito", "Immacolata Garofalo", "Tatiana Karpenko", "Antonio Raffaele Sparano", "Stefania Amatrudi", "Francesco Vezzuto", "Vincenzo Intagliatore", "Chiara De Nisio", "Danilo Cotarella", "Rosaria Maria Ester Piscopo", "Martina Casillo", "Beatriz de Castro Maia Gomes", "Stefano Capizzi", "Antonella Giugliano", "Marco Santopietro", "Giovanni Capuano", "Bruno Vezzuto", "Francesco Di Nardo", "Anna Lambiase", "Federico Di Silvio", "Salvatore De Luca", "Maria Cristina Buono", "Roberto Portolano", "Tania Velluso", "Katia De Lucia", "Vincenza Piccolo", "Annamaria De Michele", "Roberto Gambardella", "Mariavittoria La Barbera", "Emanuele Della Peruta", "Ciro Secondulfo", "Lorenzo Brescanzin", "Bourouiba Kamil", "Walter Galiano", "Nicola Rigoni", "Bryan Sánchez Peralta", "Sabrina Moura dos Santos", "Jonatas Almeida Brisotti", "Stefano Sivo", "Htet Myak Moe Myint Kyal", "Ekaterina Grishina", "Umberto Breglia", "Anja Hysa", "Aleksandr Shapovalov", "Lara De Sena", "Antonia Cacciola", "Tullio Boccardo", "Antonio Palomba", "Ray Edward Kimbler", "Federico Lupotti", "Antonio Giordano", "Leonardo Daniele", "Valerio Mosca", "Serena Palumbo", "Séamus O'Connor", "Vincenzo D'Ambrosio", "Pierpaolo Siciliano", "Valerio Lisita", "Giulio Ammendola", "Simon Bestler", "Eleonora Ballarini", "Alfonso Buonaguro", "Arturo Alfani"]
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
            .navigationTitle("Contacts")
        }
        .searchable(text: $searchText)
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return arrStudentModel
        } else {
            return arrStudentModel.filter { $0.contains(searchText) }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
