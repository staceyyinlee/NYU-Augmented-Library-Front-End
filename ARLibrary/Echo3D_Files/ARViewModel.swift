//
//  File.swift
//  Test_Echo_3D
//
//  Created by Brayton Lordianto on 12/27/22.
//

import Foundation
import RealityKit

// static can be used here because we only need one instance of arView and echoViewModel in the app.
class ViewModel {
    static var arView = ARView()
    var echoViewModel = EchoViewModel()
    
    init() {
        // we will initialize the echo view model objects first
        self.echoViewModel.getDataAsNSDict(completion: self.echoViewModel.encodeAllModels)
        for model in EchoViewModel.echoModels {
            EchoViewModel.fileNameTostorageID[model.filename] = model.storageFileID
        }
        print("DEBUG: view model initialized. count of models : " + EchoViewModel.echoModels.count.description)
    }
    
    static func downloadAndRender(name: String, completion: @escaping(String) -> ()) {
        // download the corresponding entity if not already downloaded.
        EchoUsdzFileManager.downloadOne(name: name)
        print("DEBUG:Model is now downloaded for \(name)")
        
        // now we can allow the render on it's own.
        completion(name)
    }
}


//    init() {
//        // load all the models
//        getDataAsNSDict(completion: encodeAllModels)
//        // load file name to storage map
//        // for cache.
//        for model in echoModels {
//            fileNameTostorageID[model.filename] = model.storageFileID
//        }
//    }
