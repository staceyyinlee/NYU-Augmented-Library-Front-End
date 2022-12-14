//
//  TabNavigations.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/9/22.
//

import SwiftUI

struct TabNavigations: View {
    init() {
//        UITabBar.appearance().tintColor = UIColor(named: "NYU_purple")
        UITabBar.appearance().tintColor = UIColor(named: "red")
    }
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
        .onAppear {
            UITabBar.appearance().tintColor = UIColor(named: "NYU_purple")
        }
    }
}

struct TabNavigations_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigations()
    }
}
