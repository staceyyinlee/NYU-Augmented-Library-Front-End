//
//  HomeNavigatoinButton.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/7/22.
//

import SwiftUI

struct HomeNavigationButton: View {
    let item: ViewableSpaceItem
    var body: some View {
        VStack {
            Image(item.associatedImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .FeaturesButton()
                .scaledToFit()
            
            Text(item.displayText)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .foregroundColor(textColor)
        }
    }
}

struct HomeNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeNavigationButton(item: presetViewableItems.first!)
        }
    }
}
