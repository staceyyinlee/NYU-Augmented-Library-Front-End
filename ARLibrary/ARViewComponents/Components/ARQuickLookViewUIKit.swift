//
//  ARQuickLookView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/10/22.
//

// THIS FILE DOES NOT WORK 
//  ARQLViewController.swift
import UIKit
import QuickLook
import ARKit

class ARQLViewController: UIViewController, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    let item: ViewableSpaceItem
    var assetName: String {
        // we will not include usdz so here it is just the image name in most cases.
        item.associatedImageName
    }
    let assetType = "usdz"
    let allowsContentScaling = true
    let canonicalWebPageURL = URL(string: "https://github.com/ynagatomo/ARQLSanta")
    
    init(item: ViewableSpaceItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // this will be if loaded from story board, which will never happen.
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.dataSource = self
        let delay = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            self.present(previewController, animated: false, completion: nil)
        })
    }

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let path = Bundle.main.path(forResource: assetName, ofType: assetType) else {
            fatalError("Couldn't find the supported asset file.")
        }
        let url = URL(fileURLWithPath: path)
        let previewItem = ARQuickLookPreviewItem(fileAt: url)
        previewItem.allowsContentScaling = allowsContentScaling // default = true
        previewItem.canonicalWebPageURL = canonicalWebPageURL   // default = nil
        return previewItem
    }
}
