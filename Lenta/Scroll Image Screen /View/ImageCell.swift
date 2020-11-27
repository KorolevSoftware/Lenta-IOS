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
    
    
    func bind(picture:ProtoModel, repository:ProtoRepository)
    {
        self.tText.text = picture.title.isEmpty ? "Picture": picture.title
        
        repository.getQuadImage(picture: picture) { data in
            DispatchQueue.main.async {
                if case .success(let pictureData, let isCache) = data {
                    self.tImage.image = UIImage(data: pictureData)
                }
                //self.updateConstraints()
            }
        }
        self.tImage.makeRounded(5)
    }
}


