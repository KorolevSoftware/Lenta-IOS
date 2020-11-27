//
//  NetworkFlickr.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation


class NetworkFlickr
{
    public func getInterestingnes(complition: @escaping (NetworkResponse<[FlickrPicture]?>) -> ())
    {
        let searchUrl = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=f52542e77c35e91f4a50303ed505ac14&sort=relevance&extras=url_q,views,url_c,owner_name,description&format=json&nojsoncallback=1"
        
        guard let url = URL(string: searchUrl) else {
            complition(.failure(.urlError))
            return
        }
        
        NetworkService.shared.getDataAsync(url: url) { (data) in
            if case .failure(let error) = data {
                complition(.failure(error))
            }
            
            if case .success(let dataResponse, let isCache) = data {
                do {
                    let picPage = try JSONDecoder().decode(FlickrPicturePages.self, from: dataResponse)
                    complition(.success(picPage.photos.photo, isCache))
                }
                catch {
                    //print("Error decode data \(String(describing: error))")
                    complition(.failure(.decodeDataError))
                }
            }
        }
    }
    
    //    func pictureInfo(flickrPictureID:FlickrPictureID) -> FlickrPicture? {
    ////        let base = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo"
    ////        let key = "&api_key=f52542e77c35e91f4a50303ed505ac14"
    ////        let format = "&format=json&nojsoncallback=1"
    ////        let extras = "&photo_id=\(flickrPictureID.id)"
    ////        let searchUrl = base + key + format + extras
    ////
    ////        let url = URL(string: searchUrl)!
    ////
    ////        guard let data:Data = NetworkService.shared.getDataSync(url: url) else { return nil }
    ////
    //////        NetworkService.shared.
    ////        do {
    ////            let pictureInfo = try JSONDecoder().decode(FlickrPictureContainer.self, from: data).photo
    ////
    ////            return FlickrPicture(pictureInfo: pictureInfo)
    ////        }
    ////        catch {
    ////            print("Error decode data \(String(describing: error))")
    ////        }
    //
    //        return nil
    //    }
    
    func loadQuadPicture(picture:FlickrPicture, complition: @escaping (NetworkResponse<Data>) -> ())
    {
        NetworkService.shared.getDataAsync(url: picture.quadPicture, complition: complition)
    }
    
    func loadOrigPicture(picture:FlickrPicture, complition: @escaping (NetworkResponse<Data>) -> ())
    {
        NetworkService.shared.getDataAsync(url: picture.originPicture, complition: complition)
    }
    
}
