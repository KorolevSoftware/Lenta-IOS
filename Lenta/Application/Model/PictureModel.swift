//
//  PictureModel.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation

protocol ProtoModel {
    var title:String { get }
    var description:String { get }
    var authName:String { get }
    var viewCount:Int { get }
}
