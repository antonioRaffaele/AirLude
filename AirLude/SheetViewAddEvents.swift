//
//  SwiftUIView.swift
//  AirLude
//
//  Created by Valerio Mosca on 08/12/22.
//

import SwiftUI
import PhotosUI

struct SheetViewAddEvents: View {
    
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var eventDate: Date = Date()
    //@State private var qrCode: UIImage = UIImage(named: "qrCode")! //??
    @State private var duration: String = ""
    @State private var details: String = ""
    @State private var category: String = ""
    
    @State private var hour = 0
    @State private var min = 0



    var body: some View {
        NavigationView(){
            VStack{
                Spacer()
                
                List{
                    Section(){
                        
                            TextField("Event Title" ,
                                      text : $title)
                            
                            TextField("Event Description" ,
                                      text : $details)
                    }
                    
                    Section(){
                        DatePicker("Event Date", selection: $eventDate, in: Date()..., displayedComponents: .date)
                        DatePicker("Pick a time", selection: $eventDate, in: Date()..., displayedComponents: .hourAndMinute)
                        
                        HStack{
                            
                            Picker("Duration", selection: $hour) {
                                ForEach(0...4, id: \.self) {
                                    Text("\($0) hour")
                                }
                            }
                            Picker("", selection: $min) {
                                ForEach([0,10,20,30,40,50], id: \.self) {
                                    Text("\($0) min")
                                }
                            }
                        }
                    }
                        
                    Section(){
                        Picker("Category", selection: $category) {
                            ForEach(["Tournament","Course"], id: \.self) {
                                Text("\($0) ")
                            }
                        }
                    }
                    
                }.listStyle(GroupedListStyle())
                    .offset(y:-10)
                
                
            }.background(Color("sheetColor")            .ignoresSafeArea())
                //.frame(maxWidth: .infinity)
                .navigationBarTitle("Create Event", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    
                    do {
                        try
                        addEvent()
                        dismiss()
                    }catch{
                        //how do I show them the error? alerts are deprecated, Should I set the button unclickable? How?
                        print("Missing field")
                    }
                    
                }, label: {
                    Text("Done")
                }))
                .navigationBarItems(leading: Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                }))
            
        }
        //Spacer()
    }
    
    enum FormSubmissionError: Error {
            case missingInput
            case anyOtherKindofError
        }
    
    
    private func addEvent() throws{
        guard self.title != "" && self.details != ""  else {throw FormSubmissionError.missingInput}
        let newEvent = Event(context: viewContext)
        
        newEvent.title = self.title
        newEvent.details = self.details
        newEvent.eventDate = self.eventDate
        newEvent.duration = self.duration
        newEvent.category = self.category
        newEvent.id = UUID()
        //newEvent.qrCode =
        
        //newEvent.hasAStudent = self.selectedStudent

        saveEvent()
    }
    
    private func saveEvent(){
        do {
            try viewContext.save()
            print("Event saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func formatDate() -> String {
            let components = Calendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: eventDate)
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            let day = components.day ?? 0
            let month = components.month ?? 0
            let year = components.year ?? 0
             
            return "\(day)-\(month)-\(year) (\(hour):\(minute))"
        }
}


//struct SheetViewAddEvents_Previews: PreviewProvider {
//    static var previews: some View {
//        SheetViewAddEvents(selectedStudent: Student())
//    }
//}

struct SheetViewAddEvents_Previews: PreviewProvider {
    static var previews: some View {
        SheetViewAddEvents()
    }
}
    


