//
//  SwiftUIView.swift
//  AirLude
//
//  Created by Valerio Mosca on 08/12/22.
//

import SwiftUI
import PhotosUI

struct EventAddSheetView: View {
    
    var user = UserDefaults.standard.string(forKey: "username")
    
    @StateObject var viewModel: CoreDataViewModel
    
    @Environment(\.dismiss) var dismiss
    
    
    @State private var title: String = ""
    @State private var eventDate: Date = Date()
    @State private var details: String = ""
    @State private var category: String = "Tournament"
    @State private var location: String = ""
    @State private var qrCode: UIImage = UIImage(named: "qrcode_github")!
    
    @State private var hour = 0
    @State private var min = 0
    @State private var duration: String = ""
    
    
    
    var body: some View {
        NavigationView(){
            VStack{
                Spacer()
                
                List{
                    Section(){
                        TextField("Title" ,
                                  text : $title)
                        
                        TextField("Description" ,
                                  text : $details)
                        
                        TextField("Location" ,
                                  text : $location)
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
                            ForEach(["Tournament","Course","Study Session","Public Speaking"], id: \.self) {
                                Text("\($0) ")
                            }
                        }
                    }
                    
                    Section(){
                        VStack(){
                            Text("Your QR Code is processing")
                                .frame(maxWidth: .infinity)
                            Text("You'll be able to share it later!")
                                .frame(maxWidth: .infinity)
                            ProgressView()
//                            Image("qrcode_github")
//                                .resizable()
//                                .frame(width: 150, height: 150)
//                                .font(.title2)
//                                .foregroundColor(.primary)
//                                .padding(10)
//                                .cornerRadius(16).frame(maxWidth: .infinity)
                        }
                    }
                    
                }
                .clipped()
                .listStyle(GroupedListStyle())
                .offset(y:-10)
                
                
            }.background(Color("sheetColor")            .ignoresSafeArea())
            //.frame(maxWidth: .infinity)
                .navigationBarTitle("Create Event", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    
                    do {
                        duration = "\(hour)" + "h " + "\(min)" + "m"
                        print(location)
                        try
                        addEventLocal(titleIn: self.title, detailsIn: self.details, eventDateIn: self.eventDate, durationIn: self.duration, categoryIn: self.category, locationIn: self.location)
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
    
    
    private func addEventLocal(titleIn: String, detailsIn: String, eventDateIn: Date, durationIn: String, categoryIn: String, locationIn: String) throws{
        
        guard self.title != "" && self.details != "" && self.hour != 0 && self.location != ""  else {throw FormSubmissionError.missingInput}
        
        let eventId: UUID = UUID()
        
        
        do{
            //in base all'input generami la stringaJson
            let eventString = try
            convertToJsonString(titleIn: titleIn, detailsIn: detailsIn, eventDateIn: eventDateIn, durationIn: durationIn, categoryIn: categoryIn, locationIn: locationIn, idIn: eventId)
            //generami il qrCode
            qrCode = generateQRCode(from: eventString) ?? UIImage(named: "qrcode_github")!
            //per poterlo salvare, convertilo
            let qrCodePng = qrCode.pngData()!
            
            viewModel.addEvent(titleIn: titleIn, detailsIn: detailsIn, eventDateIn: eventDateIn, durationIn: durationIn, categoryIn: categoryIn, locationIn: locationIn,idIn: eventId, qrCodeIn: qrCodePng)
        }catch{
            print("Error")
        }
        
    }
    
    private func convertToJsonString(titleIn: String, detailsIn: String, eventDateIn: Date, durationIn: String, categoryIn: String, locationIn: String, idIn: UUID)throws ->String
    {
        guard self.title != "" && self.details != "" && self.hour != 0 && self.location != ""  else {throw FormSubmissionError.missingInput}
        do{
            let eventJSON: EventJSON = EventJSON(id: idIn, location: locationIn, eventDate: eventDateIn, duration: durationIn, details: detailsIn, category: categoryIn, title: titleIn, student: viewModel.getStudentJson())
            let jsonData = try JSONEncoder().encode(eventJSON)
            let jsonStr = String(data: jsonData, encoding: .utf8)!
            return jsonStr
        } catch _ as NSError {
            print("ERRORRRRR")
            return "bonase"
        }
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
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


struct EventAddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EventAddSheetView(viewModel: CoreDataViewModel())
    }
}



