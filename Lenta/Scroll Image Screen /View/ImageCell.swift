//
//  ImageCell.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet weak var tImage:UIImageView!
    @IBOutlet weak var tText:UILabel!
    
    func bind(picture:Picture)
    {
        self.tText.text = picture.title.isEmpty ? "Picture": picture.title
        
        if let data = picture.image {
            self.tImage.image = UIImage(data: data)
            self.tImage.makeRounded(5)
        }
    }
}


