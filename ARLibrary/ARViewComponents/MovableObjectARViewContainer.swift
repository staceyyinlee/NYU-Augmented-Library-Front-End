//
//  MovableObjectARView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/7/22.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct MovableObjectARView: View {
    let item: ViewableSpaceItem
    var body: some View {
        MovableObjectARViewContainer(item: item)
            .ignoresSafeArea()
    }
}

struct MovableObjectARViewContainer: UIViewRepresentable {
    let item: ViewableSpaceItem

    func makeUIView(context: Context) -> ARView {
        let anchor = AnchorEntity()
        var cancellable: Cancellable? = nil
        let arView = ARView(frame: .zero)
        
        // load the model asynchronously
        cancellable = ModelEntity.loadAsync(named: item.associatedModelName).sink { _ in
            cancellable?.cancel()
        } receiveValue: { entity in
            // set up the child and parent mask entity
            let parentEntity = ModelEntity()
            entity.scale = [0.5,0.5,0.5]
            parentEntity.addChild(entity)
            anchor.addChild(parentEntity)
            arView.scene.addAnchor(anchor)
            
            // set up collisions and gestures
            // Add a collision component to the parentEntity with a rough shape and appropriate offset for the model that it contains
            let entityBounds = entity.visualBounds(relativeTo: parentEntity)
            parentEntity.collision = CollisionComponent(shapes: [ShapeResource.generateBox(size: entityBounds.extents).offsetBy(translation: entityBounds.center)])
            arView.installGestures(for: parentEntity)
            print("DEBUG: FINISHED LOADING MODEL")
        }
        
        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


struct MovableObjectARView_Previews: PreviewProvider {
    static var previews: some View {
        MovableObjectARView(item: presetViewableItems.first!)
    }
}
