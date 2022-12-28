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
        // load the model asynchronously
        ViewModel.downloadAndRender(name: item.associatedModelName + ".usdz", completion: placeModelAsync)
        return ViewModel.arView
        
    }
    
    // this function replaces placeModelAsync if we intend to use a simple placement of the model.
    func placeModelAsync2(name: String) {
        let anchor = AnchorEntity()
        let model = EchoUsdzFileManager.getAsModelEntity(name)
        guard let model = model else { print("DEBUG: failed finding model"); return }
        anchor.addChild(model)
        ViewModel.arView.scene.addAnchor(anchor)
        print("DEBUG: finished loading model")
    }
    
    func placeModelAsync(name: String) {
        var cancellable: Cancellable? = nil
        let anchor = AnchorEntity()
        cancellable = ModelEntity.loadAsync(named: name).sink { _ in
            cancellable?.cancel()
        } receiveValue: { entity in
            print("DEBUG: Loading Model...")
            // set up the child and parent mask entity
            let parentEntity = ModelEntity()
            entity.scale = [0.5,0.5,0.5]
            parentEntity.addChild(entity)
            anchor.addChild(parentEntity)
            ViewModel.arView.scene.addAnchor(anchor)
            
            // set up collisions and gestures
            // Add a collision component to the parentEntity with a rough shape and appropriate offset for the model that it contains
            let entityBounds = entity.visualBounds(relativeTo: parentEntity)
            parentEntity.collision = CollisionComponent(shapes: [ShapeResource.generateBox(size: entityBounds.extents).offsetBy(translation: entityBounds.center)])
                ViewModel.arView.installGestures(for: parentEntity)
            print("DEBUG: FINISHED LOADING MODEL")
        }
        
        ViewModel.arView.scene.anchors.append(anchor)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
