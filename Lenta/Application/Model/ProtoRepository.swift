//
//  ProtoRepository.swift
//  Lenta
//
//  Created by Dmitry Korolev on 24.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation


protocol ProtoRepository {
    func getData(complit:@escaping ([ProtoModel])->())
    func getQuadImage(picture:ProtoModel, complit:@escaping (Data)->())
    func getOrigImage(picture:ProtoModel, complit:@escaping (Data)->())
}
