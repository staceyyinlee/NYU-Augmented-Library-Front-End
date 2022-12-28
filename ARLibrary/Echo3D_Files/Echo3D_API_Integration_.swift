//
//  Echo3D_API_Integration.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/27/22.
//


import Foundation


extension EchoViewModel {
    // we have to call this each time so that any updates on Echo3D is handled 
    // completion is made variable for custom implementations of encoding
    // completion is meant to encode the database into models, but is made escaping so it is only encoded after already received from the API.
    func getDataAsNSDict(api_key: String = "purple-bar-7285", completion: @escaping (NSDictionary?) -> ()) {
        let urlString = "https://console.echoar.xyz/query?key=" + api_key
        guard let url = URL(string: urlString) else{ print("DEBUG: NO URL FOUND"); return }
        
        // use a semaphore to ensure that other code calling this function
        // will not continue until the semaphore receives a signal
        // so that unloaded models will not be used
        let sem = DispatchSemaphore.init(value: 0)
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            print("debug data is \(data)")
            guard let data = data else { print("DEBUG: NO DATA FOUND"); return }
            
            // get the raw json data from the API
            // access it's database and call the completion on it.
            do {
                let aDictionary : NSDictionary? = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
                if let actualDictionary = aDictionary?["db"] as? NSDictionary {
                    completion(actualDictionary)
                }
                
                else {
                    print("no db")
                    completion(nil)
                }
            } catch { completion(nil) }
            
            // signal once the models are found.
            sem.signal()
        }
        
        task.resume()
        sem.wait()
    }
        
    // this function is to load all the models' information.
    func encodeAllModels(_ data: NSDictionary?) {
        guard let data = data else { print("DEBUG: NO DICTIONARY COMPLETION"); return }
        
        let keys = data.allKeys
        for key in keys {
            let singleEntry = data[key]! as! NSDictionary
            
            // get data information as a data model
            guard
                let hologram = singleEntry["hologram"] as? NSDictionary,
                let filename = hologram["filename"] as? String,
                let storageID = hologram["storageID"] as? String,
                let id = key as? String
            else { print("DEBUG: NO FILE FOUND"); return }
            let additionalData = singleEntry["additionalData"] as? NSDictionary
            let description = additionalData?["entryComment"] as? String ?? "No Description"
            let data = EchoModel(id: id, filename: filename, storageFileID: storageID, description: description)
            
            // store that data into a result
            EchoViewModel.echoModels.append(data)
            
        }
    }
}
