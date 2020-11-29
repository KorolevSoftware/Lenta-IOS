//
//  ImageInfoController.swift
//  Lenta
//
//  Created by Dmitry Korolev on 22.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import UIKit

class ImageInfoController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var pictureDiscription: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var authName: UILabel!
    
    var model:ProtoModel?
    var repository:ProtoRepository!
    
    func viewPlaceholder() {
        let noData = "no load data"
        picture.image = UIImage(named: "placeholder")
        authName.text = noData
        pictureDiscription.text = noData
        viewCount.text = "0"
        showAlertInfo(title: "Internet", message: "No internet connect")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = model else {
            return
        }
        
        // Convert html to string
        if let attributedString = try? NSMutableAttributedString(data: model.description.data(using: .utf8)!, options:
            [.documentType: NSAttributedString.DocumentType.html, ], documentAttributes: nil) {
            pictureDiscription.text = attributedString.string
        }
        
        authName.text = model.authName
        viewCount.text = String(model.viewCount)
        title = model.title
        repository.getOrigImage(picture: model) { data in
            DispatchQueue.main.async {
                if case .success(let pictureData, _) = data {
                    self.picture.image = UIImage(data: pictureData)
                }
                if case .failure(let netError) = data, netError == .noNetworkConnect {
                    self.viewPlaceholder()
                }
                if case .failure(let netError) = data {
                    print("\(netError)")
                }
            }
        }
    }
}

extension ImageInfoController: AlertPresentable {}
