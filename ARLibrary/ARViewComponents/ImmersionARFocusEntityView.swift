//
//  ImmersionARFocusEntityView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/11/22.
//

import SwiftUI
import ARKit
import RealityKit
import Combine
import FocusEntity

// MARK: THIS IS AN ALTERNATIVE TO THE TAPTOAPPEARARVIEW 
struct ImmersionARFocusEntityView: View {
    let item: ViewableSpaceItem
    @State var isShowingAlert = false
    let errorMessage = "We weren't able to detect a horizontal plane. Please try to get closer to the floor and click on it."

    var body: some View {
        ZStack {
            ImmersionARFocusEntityContainer(item: item, showingAlert: $isShowingAlert)
                .ignoresSafeArea()
        }
    }
}

struct ImmersionARFocusEntityContainer: UIViewRepresentable {
    let item: ViewableSpaceItem
    var showingAlert: Binding<Bool>
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
        
        // 4. Set up environments
        arView.environment.sceneUnderstanding.options = .occlusion
        arView.environment.sceneUnderstanding.options = .receivesLighting
        
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
        Coordinator(item: item, showingAlert: showingAlert)
        //        Coordinator()
    }
}

extension ImmersionARFocusEntityContainer {
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        let item: ViewableSpaceItem
        var rendered = false
        var showingAlert: Binding<Bool>
        var focusEntity: FocusEntity?
        
        init(item: ViewableSpaceItem, showingAlert: Binding<Bool>) {
            self.item = item
            self.showingAlert = showingAlert
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
            // use the focus entity dependency
            if !rendered {
                self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
            }
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
                
                // delete the green focus entity square
                let position = focusEntity!.position
                self.focusEntity?.destroy()
                self.view?.scene.anchors.removeAll()

                // place the object
                // placeObjectAsync(view: view, pos)
                // alternatively, place the object based on the focus entity
                placeObjectAsync(view: view, position)
                
                // ensure it will only render once
                rendered = true
                
            } else {
                // make an alert that it did not work the first time, so tap again.
                showingAlert.wrappedValue.toggle()
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
