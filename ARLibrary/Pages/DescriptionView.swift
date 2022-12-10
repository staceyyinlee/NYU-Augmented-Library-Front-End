//
//  DescriptionView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/9/22.
//

import SwiftUI

struct DescriptionView: View {
    let item: ViewableSpaceItem
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection()
                
                ARNavigationButtons()
                
                titleSection()
            }
        }
        .ignoresSafeArea()
        .background(.thinMaterial)
    }
}

extension DescriptionView {
    func imageSection() -> some View {
        TabView {
            Image(item.associatedImageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                .clipped()
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
        .shadow(color: .black.opacity(0.3), radius:20, y: 10)
    }
    
    func ARNavigationButtons() -> some View {
        VStack {
            NavigationLink {
                MovableObjectARView(item: item)
            } label: {
                NavigationLinkLabelView("Play With Miniature 3D Space")
            }

            NavigationLink {
                TapToAppearViewContainer(item: item)
            } label: {
                NavigationLinkLabelView("Immerse Youself in the 3D Space")
            }
        }
    }
    
    func NavigationLinkLabelView(_ text: String) -> some View {
        Text(text)
            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width - 20)
            .frame(height: 40)
            .foregroundColor(.white)
            .background(Color.black)
    }
    
    func titleSection() -> some View {
        VStack(alignment: .leading) {
            Text(item.displayText)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    if let url = URL(string: item.reserveURL) {
                        Link("Learn More or Reserve", destination: url)
                            .font(.headline)
                            .tint(.blue)
                    }
                Text("\n\n\n\n\n\n")
            }
            
            Divider()
            
        }
        .padding()
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DescriptionView(item: presetViewableItems.first!)
        }
    }
}
