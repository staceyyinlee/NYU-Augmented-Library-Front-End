//
//  HomeView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/7/22.
//

import SwiftUI

struct HomeView: View {
    let descriptionText = "Tap on a button above to explore the library in Augmented Reality!"
    let welcomeText = "Welcome to the NYU Dibner Library App"
    let torchGifName = "nyu_torch"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Color("NYU_purple")
                        .frame(height: 50)
                    
                    TorchGIFView()
                        .offset(CGSize(width: 0, height: -11))

                    WelcomeView()
                        .padding(.bottom, 40)
                        .padding(.horizontal, 50)

                    
                    // different styles to align the buttons
                    // FullButtonViews()
                    FullButtonViewsDouble()

                    DescriptionView()
                        .padding(.top, 40)
                        .padding(.horizontal, 50)
                    
                    Spacer()
                }
                .ignoresSafeArea()
            }
        }
    }
}

extension HomeView {
    
    func DescriptionView() -> some View {
        Text(descriptionText)
            .multilineTextAlignment(.center)
            .foregroundColor(Color("NYU_purple"))
        
    }
    
    func WelcomeView() -> some View {
        Text(welcomeText)
            .font(.title)
            .bold()
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
    }
    
    func TorchGIFView() -> some View {
        GIFView(type: URLType.name(torchGifName))
            .frame(height: 150)
    }
    
    func NavigationButtonView(item: ViewableSpaceItem) -> some View {
        NavigationLink {
            ARLibrary.DescriptionView(item: item)
                .ignoresSafeArea()
        } label: {
            HomeNavigationButton(item: item)
                .foregroundColor(.black)
                .padding(5)
        }
    }
    
    func FullButtonViews() -> some View {
        HStack {
            ForEach(presetViewableItems, id: \.self) {
                NavigationButtonView(item: $0)
            }
        }
    }
    
    func FullButtonViewsDouble() -> some View {
        VStack {
            ForEach(0..<2) { i in
                HStack {
                    // will have to change based on elements num
                    ForEach(0..<2) { j in
                        Spacer()
                        NavigationButtonView(item: presetViewableItems[i + j*2])
                        Spacer()
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
