//
//  QuickLookARView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/10/22.
//

import SwiftUI

// MARK: THIS VIEW IS NOT USED IN THE MAIN APP. 
// MARK: https://levelup.gitconnected.com/creating-an-ios-ar-app-using-the-ar-quick-look-api-fe31aede5267

struct QuickLookARView: View {
    let item: ViewableSpaceItem
    var body: some View {
        ARQLView(item: item)
    }
}

struct ARQLView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARQLViewController
    let item: ViewableSpaceItem

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> ARQLViewController {
        let viewController = ARQLViewController(item: item)
        return viewController
    }

    func updateUIViewController(_ uiViewController: ARQLViewController, context: Context) {
    }

    class Coordinator: NSObject {
        var parent: ARQLView
        init(_ parent: ARQLView) {
            self.parent = parent
        }
    }
}



struct QuickLookARView_Previews: PreviewProvider {
    static var previews: some View {
        QuickLookARView(item: presetViewableItems.first!)
    }
}
