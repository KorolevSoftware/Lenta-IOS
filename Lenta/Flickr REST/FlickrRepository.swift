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
    func getQuadImage(picture: ProtoModel, complit: @escaping (Data) -> ()) {
        guard let flPicture:FlickrPicture = picture as? FlickrPicture else {return}
        DispatchQueue.global().async {
            self.network.loadQuadPicture(picture: flPicture, complit: complit)
        }
    }
    
    func getOrigImage(picture: ProtoModel, complit: @escaping (Data) -> ()) {
        guard let flPicture:FlickrPicture = picture as? FlickrPicture else {return}
        DispatchQueue.global().async {
            self.network.loadQuadPicture(picture: flPicture, complit: complit)
        }
    }
    
    var network:NetworkFlickr
    
    init() {
        self.network = NetworkFlickr()
    }
    
    func getData(complit: @escaping ([ProtoModel]) -> ()) {
        DispatchQueue.global().sync {
            self.network.getInterestingnes { data in
            
            var pictureArray = [FlickrPicture]()
            
            for pictureID in data {
                if let newPicture = self.network.pictureInfo(flickrPictureID: pictureID){
                    pictureArray.append(newPicture)
                }
            }
            
            DispatchQueue.main.async {
                complit(pictureArray)
            }
            }
        }
        
    }
    
}
