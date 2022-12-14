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
    
    // preset texts
    let miniature3DText = "Play With Miniature 3D Space"
    let immersion3DText = "Immerse Youself in the 3D Space"
    let miniatureInfoText = "You will see the 3D space as a miniature model that you can play around with. Try pinching, rotating, and moving the model around on the screen!"
    let immersionInfoText = "Focus on a floor horizontal plane and tap. If it worked, you should see the 3D space enlarged. Immerse youself in it!"
    
    // for the alerts
    enum AlertType { case miniature; case immersion }
    @State var isShowingAlertMiniature = false
    @State var isShowingAlertImemrsion = false
    
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
        
        // add the alerts
        .alert(miniatureInfoText, isPresented: $isShowingAlertMiniature) {
            Button("OK", role: .cancel) {}
        }
        .alert(immersionInfoText, isPresented: $isShowingAlertImemrsion) {
            Button("OK", role: .cancel) {}
        }
        
        // add the full screen covers only if we are using ARNavigationButtons
        .fullScreenCover(isPresented: $isShowingMiniAR) {
            ARNavigationDestination(mainView: MovableObjectARView(item: item), dismissState: 1)
        }
        .fullScreenCover(isPresented: $isShowingImmersionAR) {
            ARNavigationDestination(mainView: ImmersionARFocusEntityView(item: item), dismissState: 2)
            
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
                NavigationLinkLabelView(miniature3DText, .miniature)
            }
            
            NavigationLink {
                TapToAppearARView(item: item)
            } label: {
                NavigationLinkLabelView(immersion3DText, .immersion)
            }
        }
    }
    
    // alternative to the 'ARNavigationLinks' view
    func ARNavigationButtons() -> some View {
        VStack {
            Button {                self.isShowingMiniAR.toggle()
            } label: {
                NavigationLinkLabelView(miniature3DText, .miniature)
            }
            
            Button {
                self.isShowingImmersionAR.toggle()
            } label: {
                NavigationLinkLabelView(immersion3DText, .immersion)
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
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .cornerRadius(20)
                    .padding()
                    .padding(.top, 10)
                }
            }
        }
    }
    
    func NavigationLinkLabelView(_ text: String, _ alertType: AlertType) -> some View {
        ZStack {
            Text(text)
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width - 20)
                .frame(height: 40)
                .foregroundColor(.white)
                .background(Color.black)
                .shadow(radius: 10)
            
            HStack {
                Spacer()
                Button {
                    switch alertType {
                    case .immersion: isShowingAlertImemrsion.toggle()
                    case .miniature: isShowingAlertMiniature.toggle()
                    }
                } label: {
                    Image(systemName: "info.circle.fill")
                }
            }
            .padding(.trailing, 30)
            
        }
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
struct DescriptionView_Previews2: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DescriptionView(item: presetViewableItems.first!)
                .NavigationLinkLabelView("hi", .miniature)
        }
    }
}
