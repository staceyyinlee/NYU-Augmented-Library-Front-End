//
//  DescriptionView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/9/22.
//

import SwiftUI

struct DescriptionView: View {
    let item: ViewableSpaceItem
    @State var isShowingMiniAR = false
    @State var isShowingImmersionAR = false
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection()
                
                // ARNavigationLinks()
                ARNavigationButtons()
                
                titleSection()
            }
        }
        .ignoresSafeArea()
        .background(.thinMaterial)
        // add the full screen covers only if we are using ARNavigationButtons
        .fullScreenCover(isPresented: $isShowingMiniAR) {
            ARNavigationDestination(mainView: MovableObjectARView(item: item), dismissState: 1)
        }
        .fullScreenCover(isPresented: $isShowingImmersionAR) {
            ARNavigationDestination(mainView: TapToAppearViewContainer(item: item), dismissState: 2)
        }
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
    
    func ARNavigationLinks() -> some View {
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
    
    // alternative to the 'ARNavigationLinks' view
    func ARNavigationButtons() -> some View {
        VStack {
            Button {
                self.isShowingMiniAR.toggle()
            } label: {
                NavigationLinkLabelView("Play With Miniature 3D Space")
            }

            Button {
                self.isShowingImmersionAR.toggle()
            } label: {
                NavigationLinkLabelView("Immerse Youself in the 3D Space")
            }
        }
    }
    
    // works in tandom with the buttons
    // 1 refers to the miniature view and 2 refers to the immersion view 
    func ARNavigationDestination(mainView: some View, dismissState: Int) -> some View {
        ZStack {
            ZStack {
                mainView
                
                VStack {
                    Button(action: {
                        if dismissState == 1 {
                            self.isShowingMiniAR.toggle()
                        } else {
                            self.isShowingImmersionAR.toggle()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 40))
                            .padding(.horizontal, 3)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading, 10)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .cornerRadius(20)
//                    .tint(.black.opacity(1))
                    .padding()
                    .padding(.top, 10)
                }
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
