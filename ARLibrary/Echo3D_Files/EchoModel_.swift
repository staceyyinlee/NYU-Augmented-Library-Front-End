//
//  EchoModel.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/27/22.
//
import Foundation

class EchoViewModel: ObservableObject {
    static var echoModels = [EchoModel]()
    
    // easy access if needed
    static var echoModelNames: [String] { echoModels.map { $0.name } }
    static var echoModelPaths: [URL] { echoModels.map { $0.pathToDownloaded } }
    static var fileNameTostorageID = [String:String]()
}

struct EchoModel: Identifiable {
    var id: String
    var name: String {
        // the name will be the filename without the usdz part as a complete string
        guard filename.hasSuffix(".usdz") else { return "No USDZ File" }
        let suffixIndex = filename.index(filename.endIndex, offsetBy: -5)
        return filename.prefix(upTo: suffixIndex).replacingOccurrences(of: "_", with: " ")
    }
    let filename: String
    let storageFileID: String
    let description: String
    var pathToDownloaded: URL {
        EchoUsdzFileManager.getPathIfExists(fileName: self.filename).0
    }
}
