//
//  PicturePage.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation

struct PicturePages: Decodable {
    let photos:PicturePage
}

struct PicturePage: Decodable {
    let page:Int
    let pages:Int
    let perpage:Int
    let photo:[Picture]?
}
