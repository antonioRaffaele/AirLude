//
//  ContentView.swift
//  AirLude
//
//  Created by Valerio Mosca on 07/12/22.
//

import SwiftUI
import CoreData
import CodeScanner

struct EventsPage: View {
    @ObservedObject var viewModel: CoreDataViewModel
    //@EnvironmentObject var viewModel: CoreDataViewModel
    
    @State private var selectedSegment = 0
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    @State private var showingSheet = false

    @State private var isShowingScanner = false
    

    var body: some View {
            NavigationView{
                VStack{
                    Picker("Choose the section", selection: $selectedSegment) {
                        Text("Show All").tag(0)
                        Text("Created").tag(1)
                    }.padding()
                        .pickerStyle(.segmented)
                    
                    if(selectedSegment == 1){
                        if let tmp = viewModel.storedCreatedEvent{
                            List{
                                ForEach(tmp) { event in
                                    Section{
                                        NavigationLink{
                                            EventDetails(viewModel: viewModel, selectedEvent: event)
                                        } label: {
                                            CardViewEvent(event: event)
                                        }
                                        
                                    }
                                }
                                    
                            }
                            .listStyle(.insetGrouped)
                        }else{
                            Text("ssssss")
                        }
                    }else{
                        if let tmp = viewModel.storedAllEvent{
                            List{
                                ForEach(tmp) { event in
                                    Section{
                                        NavigationLink{
                                            EventDetails(viewModel: viewModel, selectedEvent: event)
                                        } label: {
                                            CardViewEvent(event: event)
                                        }
                                        
                                    }
                                }
                            }
                            .listStyle(.insetGrouped)
                        }else{
                            Text("ehehaehahe")
                        }
                    }
                }
                .background(Color(.systemGroupedBackground))
                .navigationTitle("Events")
                .toolbar{
                    ToolbarItem{
                        Button{
                            showingSheet.toggle()
                        }label: {
                            Label("Add Item", systemImage: "plus")
                        }
                        .sheet(isPresented: $showingSheet) {
                            EventAddSheetView(viewModel: viewModel)
                        }
                    }
                    ToolbarItem{
                        Button {
                            isShowingScanner = true
                        } label: {
                            Label("Scan", systemImage: "qrcode.viewfinder")
                        }
                        .sheet(isPresented: $isShowingScanner) {
                            CodeScannerView(codeTypes: [.qr], completion: handleScan)
                        }
                    }
                }
                .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
                    OnBoarding(viewModel: viewModel, shouldShowOnboarding: $shouldShowOnboarding)
                })
            }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            
            print(result.string)
            let data = result.string.data(using: .utf8)!
            do {
                let pastData: EventJSON = try JSONDecoder().decode(EventJSON.self,from: data)
                print(pastData)
                
                //generami il qrCode
                let qrCode = generateQRCode(from: result.string) ?? UIImage(named: "qrcode_github")!
                //per poterlo salvare, convertilo
                let qrCodePng = qrCode.pngData()!
                
                viewModel.addEvent(titleIn: pastData.title, detailsIn: pastData.details, eventDateIn: pastData.eventDate, durationIn: pastData.duration, categoryIn: pastData.category, locationIn: pastData.location, idIn: pastData.id, qrCodeIn: qrCodePng, userIn: pastData.student.nameSurname)
//                NavigationLink{
//                    EventPartecipation(viewModel: viewModel, scannedEvent: pastData)
//                } label: {
//                    Text("ahha")
//                }
            } catch{
                print("Error")
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
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
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

struct EventsPage_Previews: PreviewProvider {
    static var previews: some View {
        EventsPage(viewModel: CoreDataViewModel())
    }
}
