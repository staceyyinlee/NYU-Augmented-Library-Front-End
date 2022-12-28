//
//  TabNavigations.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/9/22.
//

import SwiftUI

struct TabNavigations: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                        .foregroundColor(.white)
                }
            
            VIPTeamView()
                .tabItem {
                    Image(systemName: "person")
                }
            
        }
    }
}

struct TabNavigations_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigations()
    }
}
