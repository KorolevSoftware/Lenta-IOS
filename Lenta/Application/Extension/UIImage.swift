//
//  UIImage.swift
//  Lenta
//
//  Created by Dmitry Korolev on 23.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func makeRounded(_ radius:CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
