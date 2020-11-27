//
//  Utils.swift
//  Lenta
//
//  Created by Dmitry Korolev on 27.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation
import UIKit


class Utils {
    
static func alertInfo(title:String, message:String) -> UIAlertController {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    ac.addAction(ok)
    return ac
    }
    
}
