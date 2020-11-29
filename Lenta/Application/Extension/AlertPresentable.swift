//
//  Utils.swift
//  Lenta
//
//  Created by Dmitry Korolev on 27.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation
import UIKit

protocol AlertPresentable {
    func showAlertInfo(title:String, message:String)
}

extension AlertPresentable where Self: UIViewController {
func showAlertInfo(title:String, message:String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    ac.addAction(ok)
    self.present(ac, animated: true, completion: nil)
    }
}
