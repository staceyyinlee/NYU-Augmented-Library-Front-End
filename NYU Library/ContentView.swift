//
//  ContentView.swift
//  NYU Library
//
//  Created by student on 10/28/22.
//

import SwiftUI

struct ContentView: View {
    var themeColor = Color("purpleNYU")
    var body: some View {
        
        TabView {
            ListView()
                .tabItem {
                    icon("house", "Home")
                }

            Text("")
                .tabItem {
                    icon("safari", "Tour")
                }

            SelectCalendar()
                .tabItem {
                    icon("calendar", "Calendar")
                }
        }
        .accentColor(themeColor)
    }
}

extension ContentView {
    func icon(_ name: String, _ label: String) -> some View {
        VStack {
            Image(systemName: name).renderingMode(.template)
            Text(label)
        }
    }
    
    
}

//struct CalendarView

struct HomeView: View {
    var body: some View {
        Text("")
    }
}

struct ListView: View {
    var body: some View {
        VStack {
            List {
                VStack {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text("Library Tour")
                                .bold()
                            Text("Description of Image")
                        }
                    }
                }
            }
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
