//
//  ARTest1.swift
//  NYU Library
//
//  Created by Brayton Lordianto on 10/30/22.
//

import SwiftUI
import ARKit
import RealityKit

struct ARTest1: View {
    var body: some View {
        ARView1()
    }
}

struct ARView1: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct ARTest1_Previews: PreviewProvider {
    static var previews: some View {
        ARTest1()
    }
}
