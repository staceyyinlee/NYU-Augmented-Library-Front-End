//
//  TapToAppearARView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/9/22.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

struct TapToAppearARView: View {
    let item = presetViewableItems.first!
    var body: some View {
        TapToAppearViewContainer(item: item)
    }
}

struct TapToAppearViewContainer: UIViewRepresentable {
    let item: ViewableSpaceItem
    let anchor = AnchorEntity()
    let arView = ARView(frame: .zero)

    func makeUIView(context: Context) -> ARView {
        // 1. plane detection activated
        startPlaneDetection()
        
        // 2. set up coordinator
        context.coordinator.view = arView
        arView.session.delegate = context.coordinator
        
        // 3. Add touch
        arView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )

        
        arView.scene.anchors.append(anchor)
        return arView
    }
    
    func startPlaneDetection() {
        arView.automaticallyConfigureSession = true
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        arView.session.run(config)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(item: item)
//        Coordinator()
    }
}

extension TapToAppearViewContainer {
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        let item: ViewableSpaceItem
        var rendered = false

        init(item: ViewableSpaceItem) {
            self.item = item
        }
        
        @objc
        func handleTap(recognizer: UITapGestureRecognizer) {
            print("DEBUG: TAP DETECTED")
            guard rendered == false,
                  let view = self.view else { return }
            print("DEBUG: TAP CONDITIONS SATISFIED")
            
            // get the touch location
            let tapLocation = recognizer.location(in: view)
    
            // raycast 2D -> 3D
            // horizontal raycast to detech where to put the 3D model
            let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
    
            // if the point exists, add the object at that point
            if let result = results.first {
                // 3D point
                let pos = simd_make_float3(result.worldTransform.columns.3)
    
                // place the object
                placeObjectAsync(view: view, pos)

                // ensure it will only render once
                rendered = true
            } else {
                // make an alert that it did not work the first time, so tap again. 
                
            }
            
        }
        
        func placeObjectAsync(view: ARView, _ location: SIMD3<Float>) {
            var cancellable: Cancellable? = nil

            // load the model asynchronously
            print(item.associatedModelName)
            cancellable = ModelEntity.loadAsync(named: item.associatedModelName).sink { _ in
                cancellable?.cancel()
            } receiveValue: { entity in
                let anchor = AnchorEntity(world: location)
                entity.scale = [10,10,10]
                anchor.addChild(entity)
                view.scene.addAnchor(anchor)
                print("DEBUG: FINISHED LOADING MODEL")
            }
        }
        
    }
}

struct TapToAppearARView_Previews: PreviewProvider {
    static var previews: some View {
        TapToAppearARView()
    }
}
