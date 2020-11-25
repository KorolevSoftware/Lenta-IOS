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
    
    var repository:ProtoRepository?
    
    func bind(picture:ProtoModel)
    {
        guard let repository = repository else { return }
        self.tText.text = picture.title.isEmpty ? "Picture": picture.title
        
        repository.getQuadImage(picture: picture) { data in
            self.tImage.image = UIImage(data:data)
            self.updateConstraints()
        }
        self.tImage.makeRounded(5)
    }
}


