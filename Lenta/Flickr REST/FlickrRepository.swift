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
    func getQuadImage(picture: ProtoModel, complition: @escaping (Data) -> ()) {
        guard let flPicture:FlickrPicture = picture as? FlickrPicture else {return}
        self.network.loadQuadPicture(picture: flPicture, complition: complition)
    }
    
    func getOrigImage(picture: ProtoModel, complition: @escaping (Data) -> ()) {
        guard let flPicture:FlickrPicture = picture as? FlickrPicture else {return}
        self.network.loadOrigPicture(picture: flPicture, complition: complition)
    }
    
    var network:NetworkFlickr
    
    init() {
        self.network = NetworkFlickr()
    }
    
    func getData(complition: @escaping ([ProtoModel]) -> ()) {
            self.network.getInterestingnes { data in
                var pictureArray = [FlickrPicture]()
                for pictureID in data {
                    pictureArray.append(FlickrPicture(pictureID: pictureID))
                }
            
                DispatchQueue.main.async {
                    complition(pictureArray)
                }
        }
    }
    
}
