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
    
    var model:Picture?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = model?.image {
            picture.image = UIImage(data: data)
        }
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
