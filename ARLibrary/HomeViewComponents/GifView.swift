//
//  GifView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/7/22.
//

import SwiftUI

// dependent on FLAnimatedImage
import FLAnimatedImage

enum URLType {
    // you can give a url type by name or by URL
    case name(String)
    case url(URL)
    
    var url: URL? {
        switch self {
        case .name(let name):
            return Bundle.main.url(forResource: name, withExtension: "gif")
        case .url(let remoteURL):
            return remoteURL
        }
    }
}

struct GIFView: UIViewRepresentable {
    private var type: URLType
    
    // the actual GIF as a closure
    private let imageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // consider if using corner radius
        // imageView.layer.cornerRadius = 24
        // imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // this is the loading screen while the GIF loads
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    init(type: URLType) {
        // it is set with a url
        self.type = type
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        // adding as sub view
        view.addSubview(activityIndicator)
        view.addSubview(imageView)
        
        // activate the constraints
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // here we start the loading screen and load the GIF
        activityIndicator.startAnimating()
        guard let url = type.url else {
            print("DEBUG: URL for GIF view is invalid.")
            return
        }
        
        // Asynchronously load the GIF
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = FLAnimatedImage(animatedGIFData: data)
                
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    imageView.animatedImage = image
                    
                    // this is a special work around for the specifications of the current GIF to run forever
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
                        imageView.animatedImage = nil
                        imageView.animatedImage = image
                    })
                }
            }
        }
    }
}


struct GifViewTest: View {
    @State var name = "nyu_torch"
    
    var body: some View {
        GIFView(type: URLType.name(name))
            .frame(height: 100)
    }
}

struct GifView_Previews: PreviewProvider {
    static var previews: some View {
        GifViewTest()
    }
}
