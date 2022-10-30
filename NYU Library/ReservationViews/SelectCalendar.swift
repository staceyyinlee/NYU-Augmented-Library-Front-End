//
//  SelectCalendar.swift
//  NYU Library
//
//  Created by Brayton Lordianto on 10/28/22.
//

import SwiftUI

struct SelectCalendar: View {
    @State var date = Date()
    var body: some View {
        Form {
            DatePicker("date", selection: $date)
                .datePickerStyle(.graphical)
            Text(date.description)
        }
    }
}

struct SelectCalendar_Previews: PreviewProvider {
    static var previews: some View {
        SelectCalendar()
    }
}
