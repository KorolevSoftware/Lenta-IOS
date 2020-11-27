//
//  ProtoRepository.swift
//  Lenta
//
//  Created by Dmitry Korolev on 24.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation

protocol ProtoRepository {
    func getData(complition:@escaping (NetworkResponse<[ProtoModel]>)->())
    func getQuadImage(picture:ProtoModel, complition:@escaping (NetworkResponse<Data>)->())
    func getOrigImage(picture:ProtoModel, complition:@escaping (NetworkResponse<Data>)->())
}
