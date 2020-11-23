//
//  File.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation
import UIKit


struct Picture: Decodable {
    let id:String
    let url_q:URL
    let title:String
    var image:Data?
}
