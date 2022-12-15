//
//  SelectionRow.swift
//  AirLude
//
//  Created by Valerio Mosca on 12/12/22.
//

import SwiftUI

struct SelectionRow: View {
    
    let title:String
    @Binding var selectedItem: String?
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            if title == selectedItem{
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }.contentShape(Rectangle())
            .onTapGesture {
                if (title == selectedItem) {
                    selectedItem = nil
                } else {
                    selectedItem = title
                }
            }
    }
}

struct SelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SelectionRow(title: "NoName", selectedItem: .constant("NoName"))
    }
}
