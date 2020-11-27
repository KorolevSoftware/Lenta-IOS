//
//  ZoomImageController.swift
//  Lenta
//
//  Created by Dmitry Korolev on 27.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import UIKit

class ZoomImageController: UIViewController {

    @IBOutlet weak var pictureZoom: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureZoom.image = UIImage(named: "placeholder")
        print("viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    func setImage(image:UIImage) {
        print("set image")
        pictureZoom.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
