//
//  FlickrRepository.swift
//  Lenta
//
//  Created by Dmitry Korolev on 24.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation

class FlickrRepository: ProtoRepository
{
    func getQuadImage(picture: ProtoModel, complition: @escaping (NetworkResponse<Data>) -> ()) {
        guard let flPicture = picture as? FlickrPicture else { return }
        self.network.loadQuadPicture(picture: flPicture, complition: complition)
    }
    
    func getOrigImage(picture: ProtoModel, complition: @escaping (NetworkResponse<Data>) -> ()) {
        guard let flPicture = picture as? FlickrPicture else { return }
        self.network.loadOrigPicture(picture: flPicture, complition: complition)
    }
    
    var network:NetworkFlickr
    
    init() {
        self.network = NetworkFlickr()
    }
    
    func getData(complition: @escaping (NetworkResponse<[ProtoModel]>) -> ()) {
        self.network.getInterestingnes { data in
            DispatchQueue.main.async {
                
                if case .success(let picture, let isCache) = data {
                    if let picture = picture{
                        complition(.success(picture, isCache))
                    }
                    else {
                        complition(.failure(.noDataOrResponse))
                    }
                }
                
                if case .failure(let networkError) = data {
                    complition(.failure(networkError))
                }
            }
        }
    }
}
