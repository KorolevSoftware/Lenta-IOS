//
//  ZoomImageScreen.swift
//  Lenta
//
//  Created by Dmitry Korolev on 02.12.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import UIKit

class ZoomImageScreen: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var zoomView: UIScrollView!
    
    var imageForZoom:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomView.delegate = self
        pictureView.image = imageForZoom ?? UIImage(named: "placeholder")
        }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pictureView
    }
    
    func setImage(image: UIImage?) {
        imageForZoom = image
    }
}
